defmodule Taskify.SubTasks.SubTask do
  use Ecto.Schema
  import Ecto.Changeset

  alias Taskify.Tasks.Task

  schema "sub_tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :name, :string
    belongs_to :task, Task

    timestamps()
  end

  @doc false
  def changeset(sub_task, attrs) do
    sub_task
    |> cast(attrs, [:name, :description, :completed])
    |> validate_required([:name, :completed])
  end
end
