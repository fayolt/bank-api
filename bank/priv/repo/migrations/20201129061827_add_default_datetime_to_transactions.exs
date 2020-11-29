defmodule Bank.Repo.Migrations.AddDefaultDateTimeToTransactions do
  use Ecto.Migration

  def change do
    alter table(:transactions) do 
      modify :date, :naive_datetime, [null: false, default: fragment("now()")]
    end
  end
end
