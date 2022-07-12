defmodule LiveOperationsWeb.FootballLive.Show do
  use LiveOperationsWeb, :live_view

  alias LiveOperations.Sport

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:football, Sport.get_football!(id))}
  end

  defp page_title(:show), do: "Show Football"
  defp page_title(:edit), do: "Edit Football"
end
