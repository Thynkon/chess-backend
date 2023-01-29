defmodule ChessWeb.PvCGameChannel do
  require Logger
  use ChessWeb, :channel
  alias Chess.Moves

  @impl true
  def join("pvc_game:lobby", payload, socket) do
    Logger.debug("pvc_game:lobby")

    if authorized?(payload) do
      {:ok, pid} = connect_uci()
      socket = socket |> assign(:pid, pid)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (pv_c_game:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  @impl true
  def handle_in("init_game", %{"game_id" => game_id}, socket) do
    pid = socket.assigns.pid
    game = Chess.Games.get_game!(game_id)
    socket = socket |> assign(:game_id, game_id)

    # Create game participation and set game status to 'on_going'
    game_participation = Chess.GameParticipations.get_game_participation_by_game(game.id)
    game = Chess.Games.move_next_status_game(game)

    Logger.debug("GOT GAME ==> #{inspect(game)}")

    {:ok, legal_moves} = fetch_legal_moves(pid)
    {:ok, fen} = :binbo.get_fen(pid)

    broadcast!(socket, "init_game", %{
      legal_moves: legal_moves,
      orientation: game_participation.side,
      fen: fen
    })

    {:noreply, socket}
  end

  @impl true
  def handle_in("uci_move", %{"game_id" => game_id}, socket) do
    pid = socket.assigns.pid
    game = Chess.Games.get_game!(game_id)
    game_participation = Chess.GameParticipations.get_game_participation_by_game(game.id)

    # If user is not white, let the UCI make the first move
    if game_participation.side !== :white do
      Logger.debug("Letting UCI make the first move!")
      :binbo.uci_play(pid, %{})
    end

    {:ok, legal_moves} = fetch_legal_moves(pid)
    {:ok, fen} = :binbo.get_fen(pid)

    # If UCI made the first move, log it
    if game_participation.side !== :white do
      {:ok, move} = Moves.create_move(%{game_id: game_id, fen: fen})
    end

    broadcast!(socket, "uci_move", %{
      legal_moves: legal_moves,
      fen: fen
    })

    {:noreply, socket}
  end

  @impl true
  def handle_in("play_game", %{"from" => from, "to" => to}, socket) do
    Logger.debug("Got message from play_game, from => #{from}, to => #{to}")
    pid = socket.assigns.pid
    game_id = socket.assigns.game_id
    game = Chess.Games.get_game!(game_id)

    # Play move and fetch UCI response
    # {:ok, :continue, "c7c5"} = :binbo.uci_play(pid, %{}, "#{from}#{to}")
    case :binbo.uci_play(pid, %{}, "#{from}#{to}") do
      {:ok, :continue, <<_from::16, to::binary>> = _uci_move} ->
        {:ok, fen} = :binbo.get_fen(pid)
        {:ok, legal_moves} = fetch_legal_moves(pid)

        {:ok, move} = Moves.create_move(%{game_id: game_id, fen: fen})

        broadcast!(socket, "play_game", %{
          status: "continue",
          legal_moves: legal_moves,
          fen: fen,
          uciMove: to,
          playerMove: from
        })

      {:ok, {:checkmate, winner}, _} ->
        a = Atom.to_string(winner)
        # [["black_wins", "black"]]
        matches = Regex.scan(~r/^([a-zA-Z]*)_wins$/, Atom.to_string(winner))
        Logger.debug("Winner ==> #{a}, Got matches ==> #{inspect(matches)}")
        winner = matches |> Enum.at(0) |> Enum.at(1)

        # Moving game to 'finished'
        game = Chess.Games.move_next_status_game(game)

        broadcast!(socket, "play_game", %{
          status: "checkmate",
          winner: winner
        })
    end

    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    Logger.debug("authorized?() ==> true")
    true
  end

  defp connect_uci() do
    fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    # start application
    :binbo.start()
    host = Application.fetch_env!(:chess, :stockfish_host)
    port = Application.fetch_env!(:chess, :stockfish_port)
    timeout = Application.fetch_env!(:chess, :stockfish_timeout)

    engine_path = {host, port, timeout}

    # start server
    {:ok, pid} = :binbo.new_server()

    # Connecting to UCI
    {:ok, :continue} =
      :binbo.new_uci_game(pid, %{
        engine_path: engine_path,
        fen: fen
      })

    # Show stockfish messages
    # :ok = :binbo.set_uci_handler(pid, fn m -> IO.puts(m) end)

    # Set stockfish level
    :binbo.uci_command_cast(pid, "setoption name Skill Level value 3")

    {:ok, pid}
  end

  defp fetch_legal_moves(pid) do
    {:ok, legal_moves} = :binbo.all_legal_moves(pid, :bin)

    # [
    #   {"h2", "h4"},
    #   {"h2", "h3"}
    # ]
    {:ok,
     legal_moves
     |> Enum.reduce(%{}, fn {from, to}, acc ->
       if !Map.has_key?(acc, from) do
         Map.put(acc, from, [to])
       else
         old_to = acc[from]
         old_to = [to | old_to]
         Map.put(acc, from, old_to)
       end
     end)}
  end
end
