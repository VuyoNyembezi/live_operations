defmodule LiveOperationsWeb.FootballResultsLive do
  use LiveOperationsWeb, :live_view

  alias LiveOperations.Events
  alias LiveOperations.Events.Event

  @impl true
  def mount(_params, _session, socket) do
      if connected?(socket), do: LiveOperations.Events.subscribe()
    {:ok, 
    socket
    |> assign(results: resulted_fixture())

    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end


  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Results ")
    |> assign(:event, nil)
  end

  defp resulted_fixture do
    Events.resulted_fixtures()
  end

   # definitions modules
    defp fetch(socket) do
    results_data = Events.resulted_fixtures()
  

    socket
    |> assign(results: results_data)
    
  end
   
    @impl true
  def handle_info({Events, [:event, _], _}, socket) do
    {:noreply, fetch(socket)}
  end
end
