defmodule Taskify.TasksTest do
  use Taskify.DataCase

  alias Taskify.Tasks

  describe "tasks" do
    setup [:build_user]

    alias Taskify.Tasks.Task

    import Taskify.TasksFixtures

    @invalid_attrs %{description: nil, name: nil}

    test "list_user_tasks/1 returns all tasks", %{user: user} do
      task = task_fixture(user)
      assert Tasks.list_user_tasks(user) == [task]
    end

    test "get_user_task!/2 returns the task with given id", %{user: user} do
      task = task_fixture(user)
      assert Tasks.get_user_task!(user, task.id) == task
    end

    test "create_task/2 with valid data creates a task", %{user: user} do
      valid_attrs = %{description: "some description", name: "some name"}

      assert {:ok, %Task{} = task} = Tasks.create_task(user, valid_attrs)
      assert task.description == "some description"
      assert task.name == "some name"
    end

    test "create_task/2 with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Tasks.create_task(user, @invalid_attrs)
    end

    test "update_task/2 with valid data updates the task", %{user: user} do
      task = task_fixture(user)
      update_attrs = %{description: "some updated description", name: "some updated name"}

      assert {:ok, %Task{} = task} = Tasks.update_task(task, update_attrs)
      assert task.description == "some updated description"
      assert task.name == "some updated name"
    end

    test "update_task/2 with invalid data returns error changeset", %{user: user} do
      task = task_fixture(user)
      assert {:error, %Ecto.Changeset{}} = Tasks.update_task(task, @invalid_attrs)
      assert task == Tasks.get_user_task!(user, task.id)
    end

    test "delete_task/1 deletes the task", %{user: user} do
      task = task_fixture(user)
      assert {:ok, %Task{}} = Tasks.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Tasks.get_user_task!(user, task.id) end
    end

    test "change_task/1 returns a task changeset", %{user: user} do
      task = task_fixture(user)
      assert %Ecto.Changeset{} = Tasks.change_task(task)
    end
  end

  defp build_user(_) do
    %{user: Taskify.AccountsFixtures.user_fixture()}
  end
end
