defmodule LiveOperationsWeb.PageController do
  use LiveOperationsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
