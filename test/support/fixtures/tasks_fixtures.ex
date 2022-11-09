defmodule Taskify.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Taskify.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(user, attrs \\ %{}) do
    task_attrs =
      Enum.into(attrs, %{
        description: "some description",
        name: "some name"
      })

    {:ok, task} = Taskify.Tasks.create_task(user, task_attrs)

    task
  end
end
