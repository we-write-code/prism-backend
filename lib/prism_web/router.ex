defmodule PrismWeb.Router do
  use PrismWeb, :router

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

  scope "/", PrismWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", PrismWeb do
    pipe_through :api

    post "/login", UserController, :login
    post "/signup", UserController, :signup
    resources "/users", UserController, only: [:show, :update]
  end
end
