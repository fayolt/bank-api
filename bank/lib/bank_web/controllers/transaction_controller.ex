defmodule BankWeb.TransactionController do
  use BankWeb, :controller

  action_fallback BankWeb.FallbackController

  def index(conn, _params) do
    transactions = Bank.Core.list_transactions()
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Bank.Core.Transaction{} = transaction} <- Bank.Core.process_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.transaction_path(conn, :show, transaction))
      |> render("show.json", transaction: transaction)
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Bank.Core.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Bank.Core.get_transaction!(id)

    with {:ok, %Bank.Core.Transaction{} = transaction} <- Bank.Core.update_transaction(transaction, transaction_params) do
      render(conn, "show.json", transaction: transaction)
    end
  end

end
