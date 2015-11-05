defmodule Rumbl.UserController do
	use Rumbl.Web, :controller
	plug :authenticate_user when action in [:index, :show]

	alias Rumbl.User

	def index conn, _params do
		render conn, "index.html", users: Repo.all(User)
	end

	def show conn, %{"id" => id} do
		render conn, "show.html", user: Repo.get(User, id)
	end

	def new conn, _params do
		render conn, "new.html", changeset: User.changeset(%User{})
	end

	def create conn, %{"user" => user_params} do
		changeset = User.registration_changeset %User{}, user_params
		case Repo.insert(changeset) do
			{:ok, user} ->
				conn
				|> put_flash(:info, "#{user.name} created!")
				|> Rumbl.Auth.login(user)
				|> redirect(to: user_path(conn, :index))
			{:error, changeset} ->
				render conn, "new.html", changeset: changeset
		end
	end

end
