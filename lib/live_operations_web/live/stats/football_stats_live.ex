defmodule LiveOperationsWeb.FootballStatsLive do
  use LiveOperationsWeb, :live_view

  alias LiveOperations.Sport
  alias LiveOperations.Sport.Football

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: LiveOperations.Sport.subscribe()
    {:ok, assign(socket, :football_collection, list_football())}
  end

  defp fetch(socket) do
    football_data = Sport.list_football()
    assign(socket, football_collection: football_data)
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Football")
    |> assign(:football, nil)
  end



  @impl true
  def handle_info({Sport, [:football, _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp list_football do
    Sport.list_football()
  end
end
