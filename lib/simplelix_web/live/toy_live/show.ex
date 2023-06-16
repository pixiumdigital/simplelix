defmodule SimplelixWeb.ToyLive.Show do
  use SimplelixWeb, :live_view

  alias Simplelix.Toys

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:toy, Toys.get_toy!(id))}
  end

  defp page_title(:show), do: "Show Toy"
  defp page_title(:edit), do: "Edit Toy"
end
