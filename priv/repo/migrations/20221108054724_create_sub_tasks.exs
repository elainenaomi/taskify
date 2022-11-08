defmodule Taskify.Repo.Migrations.CreateSubTasks do
  use Ecto.Migration

  def change do
    create table(:sub_tasks) do
      add :name, :string
      add :description, :text
      add :completed, :boolean, default: false, null: false
      add :task_id, references(:tasks, on_delete: :nothing)

      timestamps()
    end

    create index(:sub_tasks, [:task_id])
  end
end
