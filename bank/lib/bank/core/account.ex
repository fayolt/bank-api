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
    field :opening_date, :date
    field :type, :string, default: "SAVINGS"
    
    belongs_to :owner, Bank.Core.Customer, foreign_key: :customer_id
    has_many :initiated_transactions, Bank.Core.Transaction, foreign_key: :origin_account_id
    has_many :destined_transactions, Bank.Core.Transaction, foreign_key: :destination_account_id

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
