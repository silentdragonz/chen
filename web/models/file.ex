defmodule Chen.File do
  use Chen.Web, :model

  schema "files" do
    field :hash, :string
    field :originalname, :string
    field :filename, :string
    field :size, :integer
    field :date, Ecto.Date
    field :expire, Ecto.Date 
    field :delid, :string
    field :user, :integer
    field :dir, :integer

  end

  @required_fields ~w(hash filename originalname size date delid)
  @optional_fields ~w(expire user dir)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
