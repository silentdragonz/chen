defmodule Chen.Router do
  use Chen.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Chen do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/faq", PageController, :faq
    post "/upload", PageController, :upload
  end

  scope "/admin", Chen do
    pipe_through :browser

    resources "/", AdminController, only: [:index]
    resources "/files", AdminFilesController, only: [:index, :delete]
    get "/grid", AdminFilesController, :grid
  end

end
