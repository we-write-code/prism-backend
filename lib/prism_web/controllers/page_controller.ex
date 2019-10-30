defmodule PrismWeb.PageController do
  use PrismWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
