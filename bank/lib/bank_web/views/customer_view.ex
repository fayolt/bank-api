defmodule BankWeb.CustomerView do
  use BankWeb, :view
  alias BankWeb.CustomerView

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{id: customer.id,
      name: customer.name}
  end

end
