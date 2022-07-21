defmodule LiveOperations.EventsTest do
  use LiveOperations.DataCase

  alias LiveOperations.Events

  describe "fixtures" do
    alias LiveOperations.Events.Event

    import LiveOperations.EventsFixtures

    @invalid_attrs %{away_score: nil, home_score: nil}

    test "list_fixtures/0 returns all fixtures" do
      event = event_fixture()
      assert Events.list_fixtures() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{away_score: 42, home_score: 42}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.away_score == 42
      assert event.home_score == 42
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{away_score: 43, home_score: 43}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.away_score == 43
      assert event.home_score == 43
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "fixtures" do
    alias LiveOperations.Events.Event

    import LiveOperations.EventsFixtures

    @invalid_attrs %{active: nil, away_score: nil, home_score: nil, kickoff: nil, result: nil}

    test "list_fixtures/0 returns all fixtures" do
      event = event_fixture()
      assert Events.list_fixtures() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{active: true, away_score: 42, home_score: 42, kickoff: ~N[2022-07-13 08:22:00], result: true}

      assert {:ok, %Event{} = event} = Events.create_event(valid_attrs)
      assert event.active == true
      assert event.away_score == 42
      assert event.home_score == 42
      assert event.kickoff == ~N[2022-07-13 08:22:00]
      assert event.result == true
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{active: false, away_score: 43, home_score: 43, kickoff: ~N[2022-07-14 08:22:00], result: false}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.active == false
      assert event.away_score == 43
      assert event.home_score == 43
      assert event.kickoff == ~N[2022-07-14 08:22:00]
      assert event.result == false
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
