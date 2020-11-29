defmodule Bank.Repo.Migrations.AddDefaultOpeningDateToAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts) do 
      modify :opening_date, :date, [null: false, default: fragment("current_date")]
    end
  end
end
