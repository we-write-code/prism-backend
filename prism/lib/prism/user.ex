defmodule Prism.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :password])
    |> validate_required([:name, :password])
    |> validate_length(:name, min: 6)
    |> validate_length(:name, max: 25)
    |> hash_password()
  end

  def hash_password(user) do
    %{user | password_hash: user.password}
  end
end
