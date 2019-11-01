defmodule Prism.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
    field :first_name, :string
    field :last_name, :string
    field :username, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :first_name, :last_name])
    |> validate_required([:username, :password, :first_name, :last_name])
    |> validate_length(:username, min: 6)
    |> validate_length(:username, max: 64)
    |> validate_length(:password, min: 8)
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/.+@-+/)
    |> hash_password()
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes:
  %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp hash_password(_changeset), do: :error
end
