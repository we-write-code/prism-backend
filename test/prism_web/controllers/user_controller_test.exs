defmodule PrismWeb.UserControllerTest do
  use PrismWeb.ConnCase

  alias Prism.User
  alias Prism.Repo
  alias PrismWeb.Endpoint

  @create_attrs %{username: "TESTUSER", password: "TESTPWD"}

  describe "Userless Tests" do
    setup do
      {:ok, conn: setup_conn()}
    end

    test "POST /api/signup", %{conn: conn} do
      conn = conn
        |> post("/api/signup", [
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
  end

  describe "Tests requiring existing Users" do
    setup do
      user = setup_user()
      token = Phoenix.Token.sign(Endpoint, "PRISM#{user.username}", user.id)

      conn = setup_conn()
        |> put_req_header("authorization", token)

      {:ok, conn: conn, user: user}
    end

    test "POST /api/login", %{conn: conn, user: user} do
      conn = conn
        |> post("/api/login", [username: user.username, password: user.password])
        |> doc()

      assert conn.status == 200
    end

    test "GET /api/user/<id>", %{conn: conn, user: user} do
      conn
        |> get("/api/user/#{user.id}")
        |> doc()
        |> json_response(200)
        |> assert_user_json(%{ id: user.id, username: user.username })
        |> assert()
    end

    test "PUT /api/user/<id>", %{conn: conn, user: user} do
      new_data = %{username: "NEWUSER"}

      conn
        |> put("/api/user/#{user.id}", new_data)
        |> doc()
        |> json_response(200)
        |> assert_user_json(%{ id: user.id, username: new_data.username })
        |> assert()
    end
  end

  defp setup_user() do
    Repo.insert!(struct(User, @create_attrs))
  end

  defp setup_conn() do
    build_conn()
      |> put_req_header("accept", "application/json")
  end

  defp assert_user_json(response, expected) do
    Enum.member?(response.data, expected)
  end
end
