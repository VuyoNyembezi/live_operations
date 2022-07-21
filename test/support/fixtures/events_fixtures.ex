defmodule LiveOperations.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveOperations.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        away_score: 42,
        home_score: 42
      })
      |> LiveOperations.Events.create_event()

    event
  end

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        active: true,
        away_score: 42,
        home_score: 42,
        kickoff: ~N[2022-07-13 08:22:00],
        result: true
      })
      |> LiveOperations.Events.create_event()

    event
  end
end
