defmodule SimplelixWeb.ToyLive.Index do
  use SimplelixWeb, :live_view

  alias Simplelix.Toys
  alias Simplelix.Toys.Toy

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :toys, Toys.list_toys())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Toy")
    |> assign(:toy, Toys.get_toy!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Toy")
    |> assign(:toy, %Toy{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Toys")
    |> assign(:toy, nil)
  end

  @impl true
  def handle_info({SimplelixWeb.ToyLive.FormComponent, {:saved, toy}}, socket) do
    {:noreply, stream_insert(socket, :toys, toy)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    toy = Toys.get_toy!(id)
    {:ok, _} = Toys.delete_toy(toy)

    {:noreply, stream_delete(socket, :toys, toy)}
  end
end
