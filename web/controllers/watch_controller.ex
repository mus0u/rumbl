defmodule Rumbl.WatchController do
	use Rumbl.Web, :controller

	def show conn, %{"id" => id} do
		render conn, "show.html", video: Repo.get! Rumbl.Video, id
	end
end
