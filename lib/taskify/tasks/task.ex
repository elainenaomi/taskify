defmodule Taskify.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  alias Taskify.Accounts.User

  schema "tasks" do
    field :description, :string
    field :name, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :description])
    |> validate_required([:name])
  end
end
