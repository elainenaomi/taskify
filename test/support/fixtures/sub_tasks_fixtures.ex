defmodule Taskify.SubTasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Taskify.SubTasks` context.
  """

  @doc """
  Generate a sub_task.
  """
  def sub_task_fixture(task, attrs \\ %{}) do
    sub_task_attrs =
      attrs
      |> Enum.into(%{
        completed: true,
        description: "some description",
        name: "some name"
      })

    {:ok, sub_task} = Taskify.SubTasks.create_sub_task(task, sub_task_attrs)

    sub_task
  end
end
