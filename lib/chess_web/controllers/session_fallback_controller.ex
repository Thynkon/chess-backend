defmodule ChessWeb.SessionFallbackController do
  use Phoenix.Controller
  alias ChessWeb.ErrorView
  require Logger

  def call(conn, {:error, :invalid_credentials}) do
    conn
    |> put_status(:unauthorized)
    |> put_view(ErrorView)
    |> render(:"401", reason: "Invalid credentials")
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(ErrorView)
    |> render(:"404", reason: "Not found")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(403)
    |> put_view(ErrorView)
    |> render(:"403", reason: "Forbidden access")
  end
end
