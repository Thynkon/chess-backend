defmodule ChessWeb.GameFallbackController do
  use Phoenix.Controller
  alias ChessWeb.EctoView
  alias Plug.Conn.Status
  require Logger

  def call(
        conn,
        {:error,
         %Ecto.Changeset{errors: [{:username, {_, [constraint: :unique, constraint_name: _]}}]} =
           changeset}
      ) do
    # HTTP 409
    conn
    |> put_status(:conflict)
    |> put_view(EctoView)
    |> render(:changeset, changeset: changeset, status: Status.code(:conflict))
  end

  def call(
        conn,
        {
          :error,
          %Ecto.Changeset{
            errors: [
              {:password,
               {_,
                [
                  password: {
                    "should be at least 5 character(s)",
                    [count: 5, validation: :length, kind: :min, type: :stringa]
                  }
                ]}}
            ]
          } = changeset
        }
        # %Ecto.Changeset{errors: [{:password, {_, [validation: :length]}}]} = changeset
        # changeset
      ) do
    # HTTP 422
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(EctoView)
    |> render(:changeset, changeset: changeset, status: Status.code(:unprocessable_entity))
  end

  def call(conn, params) do
    Logger.debug("Fallback controller ==> #{inspect(params)}")
  end
end
