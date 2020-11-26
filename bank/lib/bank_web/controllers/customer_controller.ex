defmodule BankWeb.CustomerController do
  use BankWeb, :controller

  def index(conn, _params) do
    customers = Bank.Core.list_customers()
    render(conn, "index.json", customers: customers)
  end

  def create(conn, %{"customer" => customer_params}) do
    with {:ok, %Bank.Core.Customer{} = customer} <- Bank.Core.create_customer(customer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.customer_path(conn, :show, customer))
      |> render("show.json", customer: customer)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Bank.Core.get_customer!(id)
    render(conn, "show.json", customer: customer)
  end

  def update(conn, %{"id" => id, "customer" => customer_params}) do
    customer = Core.get_customer!(id)

    with {:ok, %Customer{} = customer} <- Core.update_customer(customer, customer_params) do
      render(conn, "show.json", customer: customer)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Core.get_customer!(id)

    with {:ok, %Customer{}} <- Core.delete_customer(customer) do
      send_resp(conn, :no_content, "")
    end
  end

end
