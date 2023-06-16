defmodule Simplelix.Toys.Toy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "toys" do
    field :price, :float
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(toy, attrs) do
    toy
    |> cast(attrs, [:title, :price])
    |> validate_required([:title, :price])
    |> unique_constraint(:title)
  end
end
