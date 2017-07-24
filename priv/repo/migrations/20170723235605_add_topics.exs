defmodule Discuss.Repo.Migrations.AddTopics do
	# For generating migration: 'mix ecto.gen.migration add_#{plural form of model name}'
	# For running migration: 'mix ecto.migrate'
  use Ecto.Migration

  def change do
  	# Where we will instruct db what type of structure we want it have.
  	create table(:topics) do 
  		# First argument: column name, Second: type of object
  		add :title, :string
  	end 
  end
end
