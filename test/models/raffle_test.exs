defmodule Raffle.RaffleTest do
  use Raffle.ModelCase

  alias Raffle.Raffle

  @valid_attrs %{url: "some content", description: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Raffle.changeset(%Raffle{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Raffle.changeset(%Raffle{}, @invalid_attrs)
    refute changeset.valid?
  end
end
