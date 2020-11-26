defmodule BankWeb.AccountController do
  use BankWeb, :controller

  def full_index(conn, _params) do
    accounts = Bank.Core.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def index(conn, %{"customer_id" => customer_id}) do
    accounts = Bank.Core.list_customer_accounts(customer_id)
    render(conn, "index.json", accounts: accounts)
  end

  def create(conn, %{"account" => account_params, "customer_id" => customer_id}) do
    account_params = Map.put(account_params, "customer_id", customer_id)
    account_params = Map.put(account_params, "number", Bank.Core.generate_account_number())
    
    with {:ok, %Bank.Core.Account{} = account} <- Bank.Core.create_account(account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.customer_account_path(conn, :show, customer_id, account))
      |> render("show.json", account: account)
    end
  end

  def show(conn, %{"customer_id" => customer_id, "id" => id}) do
    account = Bank.Core.get_customer_account!(id, customer_id)
    render(conn, "show.json", account: account)
  end

end
