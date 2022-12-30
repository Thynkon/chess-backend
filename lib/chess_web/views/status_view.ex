defmodule ChessWeb.StatusView do
  use ChessWeb, :view
  alias ChessWeb.StatusView

  def render("index.json", %{statuses: statuses}) do
    %{data: render_many(statuses, StatusView, "status.json")}
  end

  def render("show.json", %{status: status}) do
    %{data: render_one(status, StatusView, "status.json")}
  end

  def render("status.json", %{status: status}) do
    %{
      id: status.id,
      name: status.name,
      slug: status.slug
    }
  end
end
