defmodule TimeManager.Tools.Clock do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
  The Clock schema.
  """
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clocks" do
    field :status, :boolean, default: false
    field :time, :naive_datetime
    field :user_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
    |> unique_constraint(:user_id)
  end
end
