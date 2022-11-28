defmodule ChessWeb.ErrorView do
  use ChessWeb, :view
  require Logger

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  def render("401.json", %{reason: reason}) do
    # def render("401.json", assigns) do
    # def render("401", %{reason: reason}) do
    # Logger.debug(inspect(assigns))
    # %{title: reason, code: 401}
    %{errors: %{detail: reason}}
    # %{errors: %{detail: "THIS IS MY ERROR"}}
  end

  def render("403.json", _assigns) do
    %{title: "Forbidden", code: 403}
  end

  def render("404.json", _assigns) do
    %{title: "Page not found", code: 404}
  end

  def render("422.json", _assigns) do
    %{title: "Unprocessable entity", code: 422}
  end

  def render("500.json", _assigns) do
    %{title: "Internal Server Error", code: 500}
  end

  # # By default, Phoenix returns the status message from
  # # the template name. For example, "404.json" becomes
  # # "Not Found".
  def template_not_found(template, _assigns) do
    Logger.debug(inspect(template))
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end
