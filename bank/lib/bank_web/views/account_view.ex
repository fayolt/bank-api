defmodule BankWeb.AccountView do
  use BankWeb, :view
  alias BankWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("account.json", %{account: account}) do
    %{id: account.id,
      number: account.number,
      alias: account.alias,
      type: account.type,
      balance: account.balance,
      currency: account.currency,
      opening_date: account.opening_date}
  end

  def render("balance.json", %{account: account}), do: %{balance: account.balance}
end
