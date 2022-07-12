defmodule LiveOperations.SportTest do
  use LiveOperations.DataCase

  alias LiveOperations.Sport

  describe "football" do
    alias LiveOperations.Sport.Football

    import LiveOperations.SportFixtures

    @invalid_attrs %{badge: nil, draw: nil, loss: nil, name: nil, points: nil, win: nil}

    test "list_football/0 returns all football" do
      football = football_fixture()
      assert Sport.list_football() == [football]
    end

    test "get_football!/1 returns the football with given id" do
      football = football_fixture()
      assert Sport.get_football!(football.id) == football
    end

    test "create_football/1 with valid data creates a football" do
      valid_attrs = %{badge: "some badge", draw: 42, loss: 42, name: "some name", points: 42, win: 42}

      assert {:ok, %Football{} = football} = Sport.create_football(valid_attrs)
      assert football.badge == "some badge"
      assert football.draw == 42
      assert football.loss == 42
      assert football.name == "some name"
      assert football.points == 42
      assert football.win == 42
    end

    test "create_football/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sport.create_football(@invalid_attrs)
    end

    test "update_football/2 with valid data updates the football" do
      football = football_fixture()
      update_attrs = %{badge: "some updated badge", draw: 43, loss: 43, name: "some updated name", points: 43, win: 43}

      assert {:ok, %Football{} = football} = Sport.update_football(football, update_attrs)
      assert football.badge == "some updated badge"
      assert football.draw == 43
      assert football.loss == 43
      assert football.name == "some updated name"
      assert football.points == 43
      assert football.win == 43
    end

    test "update_football/2 with invalid data returns error changeset" do
      football = football_fixture()
      assert {:error, %Ecto.Changeset{}} = Sport.update_football(football, @invalid_attrs)
      assert football == Sport.get_football!(football.id)
    end

    test "delete_football/1 deletes the football" do
      football = football_fixture()
      assert {:ok, %Football{}} = Sport.delete_football(football)
      assert_raise Ecto.NoResultsError, fn -> Sport.get_football!(football.id) end
    end

    test "change_football/1 returns a football changeset" do
      football = football_fixture()
      assert %Ecto.Changeset{} = Sport.change_football(football)
    end
  end
end
