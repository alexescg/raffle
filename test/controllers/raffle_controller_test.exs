defmodule Raffle.RaffleControllerTest do
  use Raffle.ConnCase

  alias Raffle.Raffle
  @valid_attrs %{url: "some content", description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, raffle_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing raffles"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, raffle_path(conn, :new)
    assert html_response(conn, 200) =~ "New raffle"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, raffle_path(conn, :create), raffle: @valid_attrs
    assert redirected_to(conn) == raffle_path(conn, :index)
    assert Repo.get_by(Raffle, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, raffle_path(conn, :create), raffle: @invalid_attrs
    assert html_response(conn, 200) =~ "New raffle"
  end

  test "shows chosen resource", %{conn: conn} do
    raffle = Repo.insert! %Raffle{}
    conn = get conn, raffle_path(conn, :show, raffle)
    assert html_response(conn, 200) =~ "Show raffle"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, raffle_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    raffle = Repo.insert! %Raffle{}
    conn = get conn, raffle_path(conn, :edit, raffle)
    assert html_response(conn, 200) =~ "Edit raffle"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    raffle = Repo.insert! %Raffle{}
    conn = put conn, raffle_path(conn, :update, raffle), raffle: @valid_attrs
    assert redirected_to(conn) == raffle_path(conn, :show, raffle)
    assert Repo.get_by(Raffle, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    raffle = Repo.insert! %Raffle{}
    conn = put conn, raffle_path(conn, :update, raffle), raffle: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit raffle"
  end

  test "deletes chosen resource", %{conn: conn} do
    raffle = Repo.insert! %Raffle{}
    conn = delete conn, raffle_path(conn, :delete, raffle)
    assert redirected_to(conn) == raffle_path(conn, :index)
    refute Repo.get(Raffle, raffle.id)
  end
end
