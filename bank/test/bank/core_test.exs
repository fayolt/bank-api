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

  describe "accounts" do
    alias Bank.Core.Account

    @valid_attrs %{alias: "some alias", balance: 120.5, currency: "some currency", number: "some number", opening_date: ~D[2010-04-17], type: "some type"}
    @update_attrs %{alias: "some updated alias", balance: 456.7, currency: "some updated currency", number: "some updated number", opening_date: ~D[2011-05-18], type: "some updated type"}
    @invalid_attrs %{alias: nil, balance: nil, currency: nil, number: nil, opening_date: nil, type: nil}

    def account_fixture(attrs \\ %{}) do
      {:ok, account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_account()

      account
    end

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Core.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Core.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      assert {:ok, %Account{} = account} = Core.create_account(@valid_attrs)
      assert account.alias == "some alias"
      assert account.balance == 120.5
      assert account.currency == "some currency"
      assert account.number == "some number"
      assert account.opening_date == ~D[2010-04-17]
      assert account.type == "some type"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      assert {:ok, %Account{} = account} = Core.update_account(account, @update_attrs)
      assert account.alias == "some updated alias"
      assert account.balance == 456.7
      assert account.currency == "some updated currency"
      assert account.number == "some updated number"
      assert account.opening_date == ~D[2011-05-18]
      assert account.type == "some updated type"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_account(account, @invalid_attrs)
      assert account == Core.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Core.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Core.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Core.change_account(account)
    end
  end
end
