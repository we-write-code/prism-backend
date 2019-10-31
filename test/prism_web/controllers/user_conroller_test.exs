defmodule PrismWeb.UserControllerTest do
  use PrismWeb.ConnCase

  alias Prism.User
  alias Prism.Repo

  @create_attrs %{username: "TESTUSER", password: "TESTPWD"}
  @key ""

  setup do
    user = create_user()
    conn = build_conn() |> put_req_header("authentication", @key)

    {:ok, conn: conn, user: user}
  end

  test "POST /signup", %{conn: conn} do
    conn = conn
      |> post("/signup", [
            username: @create_attrs.username, 
            password: @create_attrs.password
          ]
        )
      |> doc()

    user = Repo.get_by(User, username: @create_attrs.username)

    assert json_response(conn, 200) =~ %{
      "id": user.id,
      "username": user.username
    }
  end

  test "POST /login", %{conn: conn, user: user} do
    conn = conn
      |> post("/login", [username: user.username, password: user.password])
      |> doc()

    assert conn.status == 200
  end

  defp create_user() do
    Repo.insert!(struct(User, @create_attrs))
  end
end
