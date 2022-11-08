defmodule Taskify.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Taskify.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name"
      })
      |> Taskify.Tasks.create_task()

    task
  end
end
