defmodule Rumbl.User do
	use Rumbl.Web, :model

	schema "users" do
		field :name, :string
		field :username, :string
		field :password, :string, virtual: true
		field :password_hash, :string

		has_many :videos, Rumbl.Video
		has_many :annotations, Rumbl.Annotation

		timestamps
	end

	# Base validation pipeline
	def changeset model, params \\ :empty do
		model
		|> cast(params, ~w(name username), [])
		|> validate_length(:username, min: 1, max: 20)
		|> unique_constraint(:username)
	end

	# Base validations + registration-specific validations
	def registration_changeset model, params do
		model
		|> changeset(params)
		|> cast(params, ~w(password), [])
		|> validate_length(:password, min: 6, max: 100)
		|> put_pass_hash
	end


	defp put_pass_hash changeset = %Ecto.Changeset{valid?: true, changes: %{password: pass}} do
		put_change changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass)
	end
	defp put_pass_hash changeset do # don't bother hashing unless the password is valid and present.
		changeset
	end
end
