defmodule ChessWeb.EctoView do
  use ChessWeb, :view
  require Logger

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end
  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end

  def render("changeset.json", %{changeset: %Ecto.Changeset{} = changeset, status: status}) do
    Logger.debug(inspect(changeset))

    %{
      error: %{code: status, message: "Something went wrong", errors: translate_errors(changeset)}
    }
  end

  # # By default, Phoenix returns the status message from
  # # the template name. For example, "404.json" becomes
  # # "Not Found".
  def template_not_found(template, _assigns) do
    Logger.debug(inspect(template))
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
