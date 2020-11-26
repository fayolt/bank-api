defmodule Bank.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :number, :string
      add :alias, :string
      add :type, :string
      add :balance, :float
      add :currency, :string
      add :opening_date, :date
      add :customer_id, references(:customers, type: :binary_id)

      timestamps()
    end

    create index(:accounts, [:customer_id])
  end
end
