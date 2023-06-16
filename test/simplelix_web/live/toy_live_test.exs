defmodule SimplelixWeb.ToyLiveTest do
  use SimplelixWeb.ConnCase

  import Phoenix.LiveViewTest
  import Simplelix.ToysFixtures

  @create_attrs %{price: 120.5, title: "some title"}
  @update_attrs %{price: 456.7, title: "some updated title"}
  @invalid_attrs %{price: nil, title: nil}

  defp create_toy(_) do
    toy = toy_fixture()
    %{toy: toy}
  end

  describe "Index" do
    setup [:create_toy]

    test "lists all toys", %{conn: conn, toy: toy} do
      {:ok, _index_live, html} = live(conn, ~p"/toys")

      assert html =~ "Listing Toys"
      assert html =~ toy.title
    end

    test "saves new toy", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/toys")

      assert index_live |> element("a", "New Toy") |> render_click() =~
               "New Toy"

      assert_patch(index_live, ~p"/toys/new")

      assert index_live
             |> form("#toy-form", toy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#toy-form", toy: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/toys")

      html = render(index_live)
      assert html =~ "Toy created successfully"
      assert html =~ "some title"
    end

    test "updates toy in listing", %{conn: conn, toy: toy} do
      {:ok, index_live, _html} = live(conn, ~p"/toys")

      assert index_live |> element("#toys-#{toy.id} a", "Edit") |> render_click() =~
               "Edit Toy"

      assert_patch(index_live, ~p"/toys/#{toy}/edit")

      assert index_live
             |> form("#toy-form", toy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#toy-form", toy: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/toys")

      html = render(index_live)
      assert html =~ "Toy updated successfully"
      assert html =~ "some updated title"
    end

    test "deletes toy in listing", %{conn: conn, toy: toy} do
      {:ok, index_live, _html} = live(conn, ~p"/toys")

      assert index_live |> element("#toys-#{toy.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#toys-#{toy.id}")
    end
  end

  describe "Show" do
    setup [:create_toy]

    test "displays toy", %{conn: conn, toy: toy} do
      {:ok, _show_live, html} = live(conn, ~p"/toys/#{toy}")

      assert html =~ "Show Toy"
      assert html =~ toy.title
    end

    test "updates toy within modal", %{conn: conn, toy: toy} do
      {:ok, show_live, _html} = live(conn, ~p"/toys/#{toy}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Toy"

      assert_patch(show_live, ~p"/toys/#{toy}/show/edit")

      assert show_live
             |> form("#toy-form", toy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#toy-form", toy: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/toys/#{toy}")

      html = render(show_live)
      assert html =~ "Toy updated successfully"
      assert html =~ "some updated title"
    end
  end
end
