defmodule SimplelixWeb.ToyLive.FormComponent do
  use SimplelixWeb, :live_component

  alias Simplelix.Toys

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage toy records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="toy-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Toy</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{toy: toy} = assigns, socket) do
    changeset = Toys.change_toy(toy)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"toy" => toy_params}, socket) do
    changeset =
      socket.assigns.toy
      |> Toys.change_toy(toy_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"toy" => toy_params}, socket) do
    save_toy(socket, socket.assigns.action, toy_params)
  end

  defp save_toy(socket, :edit, toy_params) do
    case Toys.update_toy(socket.assigns.toy, toy_params) do
      {:ok, toy} ->
        notify_parent({:saved, toy})

        {:noreply,
         socket
         |> put_flash(:info, "Toy updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_toy(socket, :new, toy_params) do
    case Toys.create_toy(toy_params) do
      {:ok, toy} ->
        notify_parent({:saved, toy})

        {:noreply,
         socket
         |> put_flash(:info, "Toy created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
