defmodule Taskify.SubTasks.SubTask do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sub_tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :name, :string
    field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(sub_task, attrs) do
    sub_task
    |> cast(attrs, [:name, :description, :completed])
    |> validate_required([:name, :description, :completed])
  end
end
