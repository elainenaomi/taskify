defmodule Taskify.Repo.Migrations.CreateSubTasks do
  use Ecto.Migration

  def change do
    create table(:sub_tasks) do
      add :name, :string, null: false
      add :description, :text
      add :completed, :boolean, default: false, null: false
      add :task_id, references(:tasks, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:sub_tasks, [:task_id])
  end
end
