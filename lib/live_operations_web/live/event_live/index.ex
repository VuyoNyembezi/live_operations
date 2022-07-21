defmodule LiveOperationsWeb.EventLive.Index do
  use LiveOperationsWeb, :live_view

  alias LiveOperations.Events
  alias LiveOperations.Events.Event
 alias LiveOperations.Sport
  alias LiveOperations.Sport.Football
  @impl true
  def mount(_params, _session, socket) do
      if connected?(socket), do: LiveOperations.Events.subscribe()
    {:ok, assign(socket, :fixtures, list_fixtures())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Event")
    |> assign(:event, Events.get_event!(id))
  end

  defp apply_action(socket, :result, %{"id" => id}) do
    socket
    |> assign(:page_title, "Result Event")
    |> assign(:event, Events.get_event!(id))
    |> assign(:count, 0)
  end
  
  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Event")
    |> assign(:event, %Event{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Fixtures")
    |> assign(:event, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    event = Events.get_event!(id)
    {:ok, _} = Events.delete_event(event)

    {:noreply, assign(socket, :fixtures, list_fixtures())}
  end

  defp list_fixtures do
    Events.list_fixtures()
  end
  
  defp list_football do
    Sport.list_football()
  end

  # definitions modules
    defp fetch(socket) do
    fixture_data = Events.list_fixtures()
    assign(socket, fixtures: fixture_data)
  end
    @impl true
  def handle_info({Events, [:event, _], _}, socket) do
    {:noreply, fetch(socket)}
  end
end
