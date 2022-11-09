defmodule Taskify.SubTasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Taskify.SubTasks` context.
  """

  @doc """
  Generate a sub_task.
  """
  def sub_task_fixture(task, user, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        completed: true,
        description: "some description",
        name: "some name"
      })

    {:ok, sub_task} = Taskify.SubTasks.create_sub_task(attrs, user, task.id)

    sub_task
  end
end
