defmodule LiveOperations.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias LiveOperations.Repo
  alias LiveOperations.Events.Event
alias LiveOperations.Sport

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(LiveOperations.PubSub, @topic)
  end
    def subscribe("update") do
    Phoenix.PubSub.subscribe(LiveOperations.PubSub, @topic <> "update")
  end

  defp notify_subcribers({:ok, result}, event) do
    Phoenix.PubSub.broadcast(LiveOperations.PubSub, @topic, {__MODULE__, event, result} )

    Phoenix.PubSub.broadcast(
      LiveOperations.PubSub,
      @topic <> "update",
      {__MODULE__, event, result}
    )

    {:ok, result}
  end

    defp notify_subcribers({:error, reason}, _), do: {:error, reason}

  @doc """
  Returns the list of fixtures.

  ## Examples

      iex> list_fixtures()
      [%Event{}, ...]

  """

  def list_fixtures do
    query = from(r in Event, where: r.result == false)
    Repo.all(query)
    |> Repo.preload([:home,:away])
  end
    @doc """
  Returns the list of upcoming fixtures.

  ## Examples

      iex> upcoming_fixtures()
      [%Event{}, ...]

  """
  def upcoming_fixtures do
      query = from(r in Event, where: r.kickoff >= ^DateTime.utc_now and r.active == false and r.result == false)
    Repo.all(query)
    |> Repo.preload([:home,:away ])
  end
    @doc """
  Returns the list of live fixtures.

  ## Examples

      iex> live_fixtures()
      [%Event{}, ...]

  """
    def live_fixtures do
      query = from(r in Event, where: r.active == true and r.result == false)
    Repo.all(query)
    |> Repo.preload([:home,:away])
  end
    @doc """
  Returns the list of reuslts fixtures.

  ## Examples

      iex> resulted_fixtures()
      [%Event{}, ...]

  """
  def resulted_fixtures do
query = from(r in Event, where: r.active == false and r.result == true)
  Repo.all(query)
    |> Repo.preload([:home,:away])
  end

  @doc """
  Gets a single event.

  Raises `Ecto.NoResultsError` if the Event does not exist.

  ## Examples

      iex> get_event!(123)
      %Event{}

      iex> get_event!(456)
      ** (Ecto.NoResultsError)

  """
  def get_event!(id) do
     Repo.get!(Event, id)
     |> Repo.preload([:home, :away])
  end
  
  @doc """
  Creates a event.

  ## Examples

      iex> create_event(%{field: value})
      {:ok, %Event{}}

      iex> create_event(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_event(attrs \\ %{}) do
    %Event{}
    |> Event.changeset(attrs)
    |> Repo.insert()
    |> notify_subcribers([:event, :created])
  end

  @doc """
  Updates a event.

  ## Examples

      iex> update_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> update_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_event(%Event{} = event, attrs) do
    event
    |> Event.changeset(attrs)
    |> Repo.update()
    |> notify_subcribers([:event, :updated])
  end
  @doc """
  Resulting the event.

  ## Examples

      iex> result_event(event, %{field: new_value})
      {:ok, %Event{}}

      iex> result_event(event, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def result_event(%Event{} = event, attrs) do
    check_results(event.id)

    event
    |> Event.resulting_changeset(attrs)
    |> Repo.update()
    |> notify_subcribers([:event, :resulted])
  end


defp check_results(event_id) do
 results = get_event!(event_id)
home_team = Sport.get_football!(results.home_id) 
away_team = Sport.get_football!(results.away_id) 

   cond do
     results.home_score > results.away_score ->
       IO.puts("home team wins")
       Sport.win_match_football(home_team)
        Sport.loss_match_football(away_team)
     results.away_score > results.home_score ->
       IO.puts("away team wins")
        Sport.win_match_football(away_team)
        Sport.loss_match_football(home_team)
     results. away_score === results.home_score ->
        IO.puts("it's a draw")
         Sport.drew_match_football(away_team)
        Sport.drew_match_football(home_team)
    end
    
end











  @doc """
  Deletes a event.

  ## Examples

      iex> delete_event(event)
      {:ok, %Event{}}

      iex> delete_event(event)
      {:error, %Ecto.Changeset{}}

  """
  def delete_event(%Event{} = event) do
    Repo.delete(event)
    |> notify_subcribers([:event, :deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking event changes.

  ## Examples

      iex> change_event(event)
      %Ecto.Changeset{data: %Event{}}

  """
  def change_event(%Event{} = event, attrs \\ %{}) do
    Event.changeset(event, attrs)
  end
end
