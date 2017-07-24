defmodule Discuss.Topic do
# Tells Phoenix what to expect from database
# Getting model helpers from web file
	use Discuss.Web, :model

	# Tells Phoenix to look for 'topics' table in db
	schema "topics" do 
		# We expect table to have a single column called title, every value must be a string
		field :title, :string 
	end 

	# Validates a model before it gets inserted into the db
	# Validations in OO-Programming: - Have topic class, call validation method on instance of class. Then save instance to db.
	# Phoenix validations: - take some initial data, pass it through a series of functions to transform it to something else.
	# Default arguments: if no argument provided, what's next to the '\\' will be set as the default.
	def changeset(struct, params \\ %{}) do
		# Struct represents a record in the db
		# Params represents what we want to update struct with
		struct
		# Cast produces object that decribes how we want to update the database, also describes the different validation errors with the attempted update.  
		|> cast(params, [:title])
		# Validators inspect some of the different properties of the changeset. Determimes if it's valid or not.
		|> validate_required([:title]) # makes sure title isn't empty
		# returns object that represents how we're trying to update the database
	end

	# What the changeset looks like when validation fails: 
		# Discuss.Topic.changeset(struct, %{}) <- no title
			# Ecto.Changeset<action: nil, changes: %{},
 			# errors: [title: {"can't be blank", [validation: :required]}],
 			# data: #Discuss.Topic<>, valid?: false>
end 