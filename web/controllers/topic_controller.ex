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

	def index(conn, _params) do
		# retrieve the records from the db. Name of table is the argument.
		topics = Repo.all(Topic) 
		render conn, "index.html", topics: topics
	end

	def new(conn, _params) do
		# Conn = short for 'connection'. Is an Elixir struct that represents both incoming and outgoing request. 
		# Params = help us parse the URL

		# create empty changeset, takes struct and params as arguments
		changeset = Topic.changeset(%Topic{}, %{})

		render conn, "new.html", changeset: changeset # set equal to '@changeset' variable in template file. '@conn' is passed by default.
	end

	def create(conn, %{"topic" => topic}) do 
		# params object is a 'map' where the keys are string, not atoms. Therefore you have to access values with pattern matching.
		# depends on 'Ecto' framework, is responsible for changeset and the 'repo' module = portal to the db.
		changeset = Topic.changeset(%Topic{}, topic)
		# automatically detects whether input is valid
		case Repo.insert(changeset) do
			{:ok, _topic} -> 
				conn 
				# alerts user about successful creation
				|> put_flash(:info, "Topic Created")
				# redirect to index
				|> redirect(to: topic_path(conn, :index))
			{:error, changeset} ->
				render conn, "new.html", changeset: changeset
		end
	end 

	# using pattern matching to assign the id from the params to the 'topic_id' variable
	def edit(conn, %{"id" => topic_id}) do
		# using existing Topic struct to populate form
		# .get method will find single object
		topic = Repo.get(Topic, topic_id)
		changeset = Topic.changeset(topic)

		render conn, "edit.html", changeset: changeset, topic: topic
	end

	# topic object is new object 
	def update(conn, %{"id" => topic_id, "topic" => topic}) do
		old_topic = Repo.get(Topic, topic_id)
		# fetch old object
		# object that describes how we are going to migrate the existing record in db to new one
		changeset = Topic.changeset(old_topic, topic)

		case Repo.update(changeset) do
			{:ok, _topic} ->
				conn
				|> put_flash(:info, "Topic Updated")
				|> redirect(to: topic_path(conn, :index))
			{:error, changeset} -> 
				render conn, "edit.html", changeset: changeset, topic: old_topic
		end
	end 

	def delete(conn, %{"id" => topic_id}) do 
		# functions that end with '!' raises errors if operation fails
		Repo.get!(Topic, topic_id) |> Repo.delete!

		conn 
		|> put_flash(:info, "Topic Deleted")
		|> redirect(to: topic_path(conn, :index))
	end 
end