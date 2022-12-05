defmodule Chess.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :chess

  # module: Chess.Guardian,
  # error_handler: Chess.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, claims: %{typ: "access"}, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
