defmodule ChessWeb.Router do
  use ChessWeb, :router
  # <-- Add this line
  use Plug.ErrorHandler
  alias Chess.Guardian

  # and implement the callback handle_errors/2
  defp handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn |> json(%{error: message}) |> halt()
  end

  defp handle_errors(conn, _) do
    conn |> json(%{error: "unknown"}) |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
    plug Chess.CurrentUser
  end

  scope "/api", ChessWeb do
    pipe_through :api
  end

  # pipeline :auth do
  #   plug Chess.UserManager.Pipeline
  # end

  # We use ensure_auth to fail if there is no one logged in
  # pipeline :ensure_auth do
  #   plug Guardian.Plug.EnsureAuthenticated
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: ChessWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  # Maybe logged in routes
  scope "/", ChessWeb do
    pipe_through [:api]

    post "/login", SessionController, :login
    post "/register", UserController, :store
  end

  scope "/", ChessWeb do
    pipe_through [:api, :jwt_authenticated]
    post "/games", GameController, :store
    get "/logout", SessionController, :logout
    get "/show", SessionController, :show
  end
end
