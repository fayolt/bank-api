defmodule Bank.CoreTest do
  use Bank.DataCase

  alias Bank.Core

  describe "customers" do
    alias Bank.Core.Customer

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_customer()

      customer
    end

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Core.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Core.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Core.create_customer(@valid_attrs)
      assert customer.name == "some name"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{} = customer} = Core.update_customer(customer, @update_attrs)
      assert customer.name == "some updated name"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_customer(customer, @invalid_attrs)
      assert customer == Core.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Core.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Core.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Core.change_customer(customer)
    end
  end
end
