defmodule LiveOperations.Sport do
  @moduledoc """
  The Sport context.
  """

    @doc """
 Result state values
  """


  import Ecto.Query, warn: false
  alias LiveOperations.Repo

  alias LiveOperations.Sport.Football


  @topic inspect(__MODULE__)
  @played 1
  @win_match 3
  @drew_match 1
  
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
  Returns the list of football.

  ## Examples

      iex> list_football()
      [%Football{}, ...]

  """
  def list_football do
    query = from t in Football, order_by: [desc: t.points]
    Repo.all(query)
  end

  @doc """
  Gets a single football.

  Raises `Ecto.NoResultsError` if the Football does not exist.

  ## Examples

      iex> get_football!(123)
      %Football{}

      iex> get_football!(456)
      ** (Ecto.NoResultsError)

  """
  def get_football!(id), do: Repo.get!(Football, id)

  @doc """
  Creates a football.

  ## Examples

      iex> create_football(%{field: value})
      {:ok, %Football{}}

      iex> create_football(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_football(attrs \\ %{}) do
    %Football{}
    |> Football.changeset(attrs)
    |> Repo.insert()
    |> notify_subcribers([:football, :created])
  end

  @doc """
  Updates a football.

  ## Examples

      iex> update_football(football, %{field: new_value})
      {:ok, %Football{}}

      iex> update_football(football, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_football(%Football{} = football, attrs) do
    football
    |> Football.changeset(attrs)
    |> Repo.update()
    |> notify_subcribers([:football, :updated])
  end

    @doc """
  won a football.

  ## Examples

      iex> win_match_football(football, %{field: new_value})
      {:ok, %Football{}}

      iex> win_match_football(football, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """


  def win_match_football(%Football{} = football) do
    attrs = %{
      win: football.win +  @played,
      points: football.points + @win_match
    }
    football
    |> Football.result_changeset(attrs)
    |> Repo.update()
    |> notify_subcribers([:football, :updated])
  end

    @doc """
  Draw a match.

  ## Examples

      iex> drew_match_football(football, %{field: new_value})
      {:ok, %Football{}}

      iex> drew_match_football(football, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def drew_match_football(%Football{} = football) do
        attrs = %{
      draw: football.draw +  @played ,
      points: football.points + @drew_match
    }
    football
    |> Football.result_changeset(attrs)
    |> Repo.update()
    |> notify_subcribers([:football, :updated])
  end

  
    @doc """
  Lossing match.

  ## Examples

      iex> loss_match_football(football, %{field: new_value})
      {:ok, %Football{}}

      iex> loss_match_football(football, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def loss_match_football(%Football{} = football) do
    attrs = %{
      loss: football.loss +  @played
    }
    football
    |> Football.result_changeset(attrs)
    |> Repo.update()
    |> notify_subcribers([:football, :updated])
  end

  @doc """
  Deletes a football.

  ## Examples

      iex> delete_football(football)
      {:ok, %Football{}}

      iex> delete_football(football)
      {:error, %Ecto.Changeset{}}

  """
  def delete_football(%Football{} = football) do
    Repo.delete(football)
    |> notify_subcribers([:football, :deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking football changes.

  ## Examples

      iex> change_football(football)
      %Ecto.Changeset{data: %Football{}}

  """
  def change_football(%Football{} = football, attrs \\ %{}) do
    Football.changeset(football, attrs)
  end
end
