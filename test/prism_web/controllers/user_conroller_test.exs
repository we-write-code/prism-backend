defmodule PrismWeb.UserControllerTest do
  use PrismWeb.ConnCase

  alias Prism.User
  alias Prism.Repo

  @create_attrs %{username: "TESTUSER", password: "TESTPWD"}
  user = nil
  token = nil

  setup do
    user = user || create_user()
    conn = build_conn()
    token = token || Phoenix.Token.sign(conn, "PRISM#{user.username}", user.id)

    conn = conn
      |> put_req_header("Authorization", token)

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

    conn
      |> json_response(200)
      |> assert_user_json(%{ id: user.id, username: user.username })
      |> assert()
  end

  test "POST /login", %{conn: conn, user: user} do
    conn = conn
      |> post("/login", [username: user.username, password: user.password])
      |> doc()

    assert conn.status == 200
  end

  test "GET /user/<id>", %{conn: conn, user: user} do
    conn
      |> get("/user/#{user.id}")
      |> doc()
      |> json_response(200)
      |> assert_user_json(%{ id: user.id, username: user.username })
      |> assert()
  end

  test "PUT /user/<id>", %{conn: conn, user: user} do
    new_data = %{username: "NEWUSER"}

    conn
      |> put("/user/#{user.id}", new_data)
      |> doc()
      |> json_response(200)
      |> assert_user_json(%{ id: user.id, username: new_data.username })
      |> assert()
  end

  defp create_user() do
    Repo.insert!(struct(User, @create_attrs))
  end

  defp assert_user_json(response, expected) do
    Enum.member?(response.data, expected)
  end
end
