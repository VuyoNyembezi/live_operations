defmodule LiveOperations.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias LiveOperations.Sport.Football
  schema "fixtures" do
    field :active, :boolean, default: false
    field :away_score, :integer, default: 0
    field :home_score, :integer, default: 0
    field :kickoff, :naive_datetime
    field :result, :boolean, default: false
    # field :home_id, :id
    # field :away_id, :id

      belongs_to :home, Football, foreign_key: :home_id
      belongs_to :away, Football, foreign_key: :away_id

    
    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:home_id , :away_id, :home_score, :away_score, :kickoff, :active, :result])
    |> validate_required([:home_id , :away_id, :home_score, :away_score, :kickoff, :active, :result])
    |> validate_number(:home_score, greater_than_or_equal_to: 0)
    |> validate_number(:away_score, greater_than_or_equal_to: 0)
    |> validate_number(:home_id, not_equal_to: :away_id)
  end
    @doc false
  def resulting_changeset(event, attrs) do
    event
    |> cast(attrs, [:home_id , :away_id, :home_score, :away_score,  :active, :result])
    |> validate_required([:home_id , :away_id, :home_score, :away_score,  :active, :result])
    |> validate_number(:home_score, greater_than_or_equal_to: 0)
    |> validate_number(:away_score, greater_than_or_equal_to: 0)
    |> put_change(:result, true)
    |> put_change(:active, false)
  end
end
