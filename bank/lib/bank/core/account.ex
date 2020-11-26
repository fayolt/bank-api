defmodule Bank.Core.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :alias, :string
    field :balance, :float
    field :currency, :string
    field :number, :string
    field :opening_date, :date, default: Date.utc_today
    field :type, :string, default: "SAVINGS"
    
    belongs_to :owner, Bank.Core.Customer, foreign_key: :customer_id

    timestamps()
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:number, :alias, :type, :balance, :currency, :opening_date, :customer_id])
    |> validate_required([:balance, :currency, :customer_id])
    |> assoc_constraint(:owner)
  end
end
