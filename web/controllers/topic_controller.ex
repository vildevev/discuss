defmodule Discuss.TopicController do
  # Defining all the behaviors needed. Make them available here. Found in '/web/web.ex'
  # Phoenix's code sharing. Functional programming version of class inheritance.
	use Discuss.Web, :controller
	# Has name of resource in singular form 
	# In OO-Programming you make reusable functionality in controllerbaseclass. Inherits those in controller.
	# In functional Programming:
		# 'Import' = copy all functions out of this module, give to another. ex: TopicController.add
		# 'Alias' = shortcut for making reference to function that's imported without having to type out name of module it belongs to. ex: add
		# 'Use' = 'really fancy setup' of other module
	alias Discuss.Topic

	def new(conn, params) do
		# Conn = short for 'connection'. Is an Elixir struct that represents both incoming and outgoing request. 
		# Params = help us parse the URL

		# create empty changeset, takes struct and params as arguments
		changeset = Topic.changeset(%Topic{}, %{})

		render conn, "new.html", changeset: changeset # set equal to '@changeset' variable in template file. '@conn' is passed by default.
	end

	def create(conn, params) do 

	end 
end