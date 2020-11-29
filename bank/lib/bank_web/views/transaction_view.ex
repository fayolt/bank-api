defmodule BankWeb.TransactionView do
  use BankWeb, :view
  alias BankWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{id: transaction.id,
      origin: transaction.origin.number,
      destination: transaction.destination.number,
      amount: transaction.amount,
      currency: transaction.currency,
      date: transaction.date,
      description: transaction.description,
      status: transaction.status,
      type: transaction.type}
  end

end
