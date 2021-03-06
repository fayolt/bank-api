defmodule BankWeb.Router do
  use BankWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BankWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", BankWeb do
    pipe_through :api

    resources "/customers", CustomerController, except: [:new, :edit] do
      # nesting /accounts resources into /customers since an account belongs to a customer
      resources "/accounts", AccountController, only: [:index, :create, :show]
    end
    resources "/transactions", TransactionController, except: [:new, :edit]
    get "/accounts", AccountController, :full_index
    get "/accounts/:account_id/balance", AccountController, :balance
    get "/accounts/:account_id/history", AccountController, :history
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: BankWeb.Telemetry
    end
  end
end
