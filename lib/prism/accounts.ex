defmodule Prism.Accounts do
  import Ecto.Query, warn: false
  alias Prism.Repo
  alias Prism.Accounts.User

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def authenticate_user(username, password) do
    User
    |> Repo.get_by([username: username])
    |> Argon2.check_pass(password)
  end

  def get_user(id) when is_number(id) do
    User
    |> Repo.get(id)
  end

  def get_user(unique) do
    cond do
      unique =~ ~r/.+@.+/ -> Repo.get_by(User, [email: unique])
      true -> Repo.get_by(User, [username: unique])
    end
  end

  def list_users do
    User
    |> Repo.all()
  end
end
