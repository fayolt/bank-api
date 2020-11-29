defmodule Bank.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :type, :string
      add :status, :string
      add :description, :string
      add :amount, :float
      add :currency, :string
      add :date, :naive_datetime
      add :origin_account_id, references(:accounts, type: :binary_id)
      add :destination_account_id, references(:accounts, type: :binary_id)

      timestamps()
    end

    create index(:transactions, [:origin_account_id])
    create index(:transactions, [:destination_account_id])
  end
end
