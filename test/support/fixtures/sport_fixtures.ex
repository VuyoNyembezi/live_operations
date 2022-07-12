defmodule LiveOperations.SportFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveOperations.Sport` context.
  """

  @doc """
  Generate a unique football badge.
  """
  def unique_football_badge, do: "some badge#{System.unique_integer([:positive])}"

  @doc """
  Generate a unique football name.
  """
  def unique_football_name, do: "some name#{System.unique_integer([:positive])}"

  @doc """
  Generate a football.
  """
  def football_fixture(attrs \\ %{}) do
    {:ok, football} =
      attrs
      |> Enum.into(%{
        badge: unique_football_badge(),
        draw: 42,
        loss: 42,
        name: unique_football_name(),
        points: 42,
        win: 42
      })
      |> LiveOperations.Sport.create_football()

    football
  end
end
