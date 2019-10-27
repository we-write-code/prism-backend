defmodule PrismWeb.PageControllerTest do
  use PrismWeb.ConnCase

  test "GET /" do
    conn = build_conn() 
      |> get("/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
