defmodule Bank.Core.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "transactions" do
    field :amount, :float
    field :currency, :string
    field :date, :naive_datetime
    field :description, :string
    field :status, :string
    field :type, :string, default: "TRANSFER"
    
    belongs_to :origin, Bank.Core.Account, foreign_key: :origin_account_id
    belongs_to :destination, Bank.Core.Account, foreign_key: :destination_account_id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:type, :status, :description, :amount, :currency, :date, :origin_account_id, :destination_account_id])
    |> validate_required([:type, :amount, :currency, :origin_account_id, :destination_account_id])
    |> assoc_constraint(:origin)
    |> assoc_constraint(:destination)
  end
end
