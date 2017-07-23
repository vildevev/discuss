defmodule Discuss.PageController do
	# Default Controller in application. 
  use Discuss.Web, :controller

  def index(conn, _params) do
  	# Params are optional
    render conn, "index.html"
    # Find 'index.html'-file, render it, return to client.
  end
end
