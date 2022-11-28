defmodule ChessWeb.ErrorViewTest do
  use ChessWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(ChessWeb.ErrorView, "404.json", []) == %{code: 404, title: "Page not found"}
  end

  test "renders 500.json" do
    assert render(ChessWeb.ErrorView, "500.json", []) ==
             %{code: 500, title: "Internal Server Error"}
  end
end
