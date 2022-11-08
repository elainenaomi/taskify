defmodule Taskify.SubTasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Taskify.SubTasks` context.
  """

  @doc """
  Generate a sub_task.
  """
  def sub_task_fixture(attrs \\ %{}) do
    {:ok, sub_task} =
      attrs
      |> Enum.into(%{
        completed: true,
        description: "some description",
        name: "some name"
      })
      |> Taskify.SubTasks.create_sub_task()

    sub_task
  end
end
