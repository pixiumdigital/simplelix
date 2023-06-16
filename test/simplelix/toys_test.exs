defmodule Simplelix.ToysTest do
  use Simplelix.DataCase

  alias Simplelix.Toys

  describe "toys" do
    alias Simplelix.Toys.Toy

    import Simplelix.ToysFixtures

    @invalid_attrs %{}

    test "list_toys/0 returns all toys" do
      toy = toy_fixture()
      assert Toys.list_toys() == [toy]
    end

    test "get_toy!/1 returns the toy with given id" do
      toy = toy_fixture()
      assert Toys.get_toy!(toy.id) == toy
    end

    test "create_toy/1 with valid data creates a toy" do
      valid_attrs = %{}

      assert {:ok, %Toy{} = toy} = Toys.create_toy(valid_attrs)
    end

    test "create_toy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Toys.create_toy(@invalid_attrs)
    end

    test "update_toy/2 with valid data updates the toy" do
      toy = toy_fixture()
      update_attrs = %{}

      assert {:ok, %Toy{} = toy} = Toys.update_toy(toy, update_attrs)
    end

    test "update_toy/2 with invalid data returns error changeset" do
      toy = toy_fixture()
      assert {:error, %Ecto.Changeset{}} = Toys.update_toy(toy, @invalid_attrs)
      assert toy == Toys.get_toy!(toy.id)
    end

    test "delete_toy/1 deletes the toy" do
      toy = toy_fixture()
      assert {:ok, %Toy{}} = Toys.delete_toy(toy)
      assert_raise Ecto.NoResultsError, fn -> Toys.get_toy!(toy.id) end
    end

    test "change_toy/1 returns a toy changeset" do
      toy = toy_fixture()
      assert %Ecto.Changeset{} = Toys.change_toy(toy)
    end
  end

  describe "toys" do
    alias Simplelix.Toys.Toy

    import Simplelix.ToysFixtures

    @invalid_attrs %{price: nil, title: nil}

    test "list_toys/0 returns all toys" do
      toy = toy_fixture()
      assert Toys.list_toys() == [toy]
    end

    test "get_toy!/1 returns the toy with given id" do
      toy = toy_fixture()
      assert Toys.get_toy!(toy.id) == toy
    end

    test "create_toy/1 with valid data creates a toy" do
      valid_attrs = %{price: 120.5, title: "some title"}

      assert {:ok, %Toy{} = toy} = Toys.create_toy(valid_attrs)
      assert toy.price == 120.5
      assert toy.title == "some title"
    end

    test "create_toy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Toys.create_toy(@invalid_attrs)
    end

    test "update_toy/2 with valid data updates the toy" do
      toy = toy_fixture()
      update_attrs = %{price: 456.7, title: "some updated title"}

      assert {:ok, %Toy{} = toy} = Toys.update_toy(toy, update_attrs)
      assert toy.price == 456.7
      assert toy.title == "some updated title"
    end

    test "update_toy/2 with invalid data returns error changeset" do
      toy = toy_fixture()
      assert {:error, %Ecto.Changeset{}} = Toys.update_toy(toy, @invalid_attrs)
      assert toy == Toys.get_toy!(toy.id)
    end

    test "delete_toy/1 deletes the toy" do
      toy = toy_fixture()
      assert {:ok, %Toy{}} = Toys.delete_toy(toy)
      assert_raise Ecto.NoResultsError, fn -> Toys.get_toy!(toy.id) end
    end

    test "change_toy/1 returns a toy changeset" do
      toy = toy_fixture()
      assert %Ecto.Changeset{} = Toys.change_toy(toy)
    end
  end
end
