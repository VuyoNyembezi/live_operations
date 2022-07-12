defmodule LiveOperationsWeb.FootballLive.FormComponent do
  use LiveOperationsWeb, :live_component

  alias LiveOperations.Sport

  @impl true
  def update(%{football: football} = assigns, socket) do
    changeset = Sport.change_football(football)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> allow_upload(:image,
       accept: ~w(.jpg .jpeg .png ),
       max_entries: 1,
       auto_upload: true,
       progress: &handle_progress/3
     )}
  end

  @impl true
  def handle_event("validate", %{"football" => football_params}, socket) do
    changeset =
      socket.assigns.football
      |> Sport.change_football(football_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"football" => football_params}, socket) do
    save_football(socket, socket.assigns.action, football_params)
  end

  defp save_football(socket, :edit, football_params) do
    case Sport.update_football(socket.assigns.football, football_params) do
      {:ok, _football} ->
        {:noreply,
         socket
         |> put_flash(:info, "Football updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_football(socket, :new, football_params) do
    case Sport.create_football(football_params) do
      {:ok, _football} ->
        {:noreply,
         socket
         |> put_flash(:info, "Football created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp handle_progress(:image, entry, socket) do
    if entry.done? do
      path =
        consume_uploaded_entry(
          socket,
          entry,
          &upload_static_file(&1, socket)
        )

      {:noreply,
       socket
       |> put_flash(:info, "file #{entry.client_name} uploaded")
       |> update_changeset(:badge, path)}
    else
      {:noreply, socket}
    end
  end

  defp upload_static_file(%{path: path}, socket) do
    dest = Path.join("priv/static/images", Path.basename(path))
    File.cp!(path, dest)
    Routes.static_path(socket, "/images/#{Path.basename(dest)}")
  end


  def update_changeset(%{assigns: %{changeset: changeset}} = socket, key, value) do
    socket
    |> assign(:changeset, Ecto.Changeset.put_change(changeset, key, value))
  end
end
