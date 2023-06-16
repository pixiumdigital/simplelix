defmodule SimplelixWeb.Router do
  use SimplelixWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {SimplelixWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SimplelixWeb do
    pipe_through :browser

    get "/", PageController, :home

    live "/toys", ToyLive.Index, :index
    live "/toys/new", ToyLive.Index, :new
    live "/toys/:id/edit", ToyLive.Index, :edit

    live "/toys/:id", ToyLive.Show, :show
    live "/toys/:id/show/edit", ToyLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", SimplelixWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:simplelix, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SimplelixWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
