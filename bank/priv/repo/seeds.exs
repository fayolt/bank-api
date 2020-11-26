alias Bank.Core

%{"customers" => customers} = File.read!("customers.json") |> Jason.decode!

customers |> Enum.each(fn customer -> Core.create_customer(customer) end)

# new_customers = customers |> Enum.map(fn customer_data -> Core.Customer.changeset(%Core.Customer{}, customer_data) end)
# new_customers |> Enum.each(fn changeset -> Repo.insert!(changeset) end)


