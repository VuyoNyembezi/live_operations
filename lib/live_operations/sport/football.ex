defmodule LiveOperations.Sport.Football do
  use Ecto.Schema
  import Ecto.Changeset

  schema "football" do
    field :badge, :string
    field :draw, :integer
    field :loss, :integer
    field :name, :string
    field :points, :integer
    field :win, :integer
    timestamps()
  end

  @doc false
  def changeset(football, attrs) do
    football
    |> cast(attrs, [:badge, :name, :win, :draw, :loss, :points])
    |> validate_required([:badge, :name, :win, :draw, :loss, :points])
    |> validate_number(:points, greater_than_or_equal_to: 0)
    |> validate_number(:loss, greater_than_or_equal_to: 0)
    |> validate_number(:win, greater_than_or_equal_to: 0)
    |> validate_number(:draw, greater_than_or_equal_to: 0)
    |> unique_constraint(:name)
    |> unique_constraint(:badge)
  end

  @doc false
  def result_changeset(football, attrs) do
    football
    |> cast(attrs, [:badge, :name, :win, :draw, :loss, :points])
    |> validate_number(:points, greater_than_or_equal_to: 0)
    |> validate_number(:loss, greater_than_or_equal_to: 0)
    |> validate_number(:win, greater_than_or_equal_to: 0)
    |> validate_number(:draw, greater_than_or_equal_to: 0)
  end

end
