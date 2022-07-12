defmodule LiveOperationsWeb.FootballLiveTest do
  use LiveOperationsWeb.ConnCase

  import Phoenix.LiveViewTest
  import LiveOperations.SportFixtures

  @create_attrs %{badge: "some badge", draw: 42, loss: 42, name: "some name", points: 42, win: 42}
  @update_attrs %{badge: "some updated badge", draw: 43, loss: 43, name: "some updated name", points: 43, win: 43}
  @invalid_attrs %{badge: nil, draw: nil, loss: nil, name: nil, points: nil, win: nil}

  defp create_football(_) do
    football = football_fixture()
    %{football: football}
  end

  describe "Index" do
    setup [:create_football]

    test "lists all football", %{conn: conn, football: football} do
      {:ok, _index_live, html} = live(conn, Routes.football_index_path(conn, :index))

      assert html =~ "Listing Football"
      assert html =~ football.badge
    end

    test "saves new football", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.football_index_path(conn, :index))

      assert index_live |> element("a", "New Football") |> render_click() =~
               "New Football"

      assert_patch(index_live, Routes.football_index_path(conn, :new))

      assert index_live
             |> form("#football-form", football: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#football-form", football: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.football_index_path(conn, :index))

      assert html =~ "Football created successfully"
      assert html =~ "some badge"
    end

    test "updates football in listing", %{conn: conn, football: football} do
      {:ok, index_live, _html} = live(conn, Routes.football_index_path(conn, :index))

      assert index_live |> element("#football-#{football.id} a", "Edit") |> render_click() =~
               "Edit Football"

      assert_patch(index_live, Routes.football_index_path(conn, :edit, football))

      assert index_live
             |> form("#football-form", football: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#football-form", football: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.football_index_path(conn, :index))

      assert html =~ "Football updated successfully"
      assert html =~ "some updated badge"
    end

    test "deletes football in listing", %{conn: conn, football: football} do
      {:ok, index_live, _html} = live(conn, Routes.football_index_path(conn, :index))

      assert index_live |> element("#football-#{football.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#football-#{football.id}")
    end
  end

  describe "Show" do
    setup [:create_football]

    test "displays football", %{conn: conn, football: football} do
      {:ok, _show_live, html} = live(conn, Routes.football_show_path(conn, :show, football))

      assert html =~ "Show Football"
      assert html =~ football.badge
    end

    test "updates football within modal", %{conn: conn, football: football} do
      {:ok, show_live, _html} = live(conn, Routes.football_show_path(conn, :show, football))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Football"

      assert_patch(show_live, Routes.football_show_path(conn, :edit, football))

      assert show_live
             |> form("#football-form", football: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#football-form", football: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.football_show_path(conn, :show, football))

      assert html =~ "Football updated successfully"
      assert html =~ "some updated badge"
    end
  end
end
