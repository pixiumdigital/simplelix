defmodule Simplelix.ToysFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Simplelix.Toys` context.
  """

  @doc """
  Generate a toy.
  """
  def toy_fixture(attrs \\ %{}) do
    {:ok, toy} =
      attrs
      |> Enum.into(%{

      })
      |> Simplelix.Toys.create_toy()

    toy
  end

  @doc """
  Generate a unique toy title.
  """
  def unique_toy_title, do: "some title#{System.unique_integer([:positive])}"

  @doc """
  Generate a toy.
  """
  def toy_fixture(attrs \\ %{}) do
    {:ok, toy} =
      attrs
      |> Enum.into(%{
        price: 120.5,
        title: unique_toy_title()
      })
      |> Simplelix.Toys.create_toy()

    toy
  end
end
