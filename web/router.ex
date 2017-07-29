defmodule Discuss.Router do
  use Discuss.Web, :router

  # pipeline as plugs = preprocessing before request hits
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

  # Command for viewing existing routes in terminal: 'mix phoenix.routes'
  # 'scope' is about namespacing the urls. ex: all start with '/topics'
  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack

    # Whenever a Client makes a get request to '/'. Find module called 'TopicController', run 'index'-function.
    # get "/", TopicController, :index
    # get "/topics/new", TopicController, :new
    # post "/topics", TopicController, :create
    # get "/topics/:id/edit", TopicController, :edit
    # put "/topics/:id", TopicController, :update
    # 'REST'-ful naming-conventions in Phoenix include: 'new', 'create', 'index', 'delete', 'edit', 'update'
    resources "/", TopicController
    # all routes automatically generated
  end

  scope "/auth", Discuss do 
    # sends them through the browser pipeline
    pipe_through :browser 

    # should work with any provider
    get "/:provider", AuthController, :request 
    get "/:provider/callback", AuthController, :callback
  end 

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
