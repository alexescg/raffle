defmodule Raffle.Raffle do
  use Raffle.Web, :model

  schema "raffles" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :user, Raffle.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :title, :description])
    |> validate_required([:url, :title, :description])
  end

  
end
