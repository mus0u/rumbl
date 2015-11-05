# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Rumbl.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Rumbl.Repo
alias Rumbl.Category
categories = ~w(Action Comedy Documentary Drama Experimental Fantasy Horror Romance Scifi)
for category <- categories do
	Repo.get_by(Category, name: category) || Repo.insert! %Category{name: category}
end
