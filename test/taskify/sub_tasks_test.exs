defmodule Taskify.SubTasksTest do
  use Taskify.DataCase

  alias Taskify.SubTasks

  describe "sub_tasks" do
    alias Taskify.SubTasks.SubTask

    import Taskify.SubTasksFixtures

    @invalid_attrs %{completed: nil, description: nil, name: nil}

    test "list_sub_tasks/0 returns all sub_tasks" do
      sub_task = sub_task_fixture()
      assert SubTasks.list_sub_tasks() == [sub_task]
    end

    test "get_sub_task!/1 returns the sub_task with given id" do
      sub_task = sub_task_fixture()
      assert SubTasks.get_sub_task!(sub_task.id) == sub_task
    end

    test "create_sub_task/1 with valid data creates a sub_task" do
      valid_attrs = %{completed: true, description: "some description", name: "some name"}

      assert {:ok, %SubTask{} = sub_task} = SubTasks.create_sub_task(valid_attrs)
      assert sub_task.completed == true
      assert sub_task.description == "some description"
      assert sub_task.name == "some name"
    end

    test "create_sub_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SubTasks.create_sub_task(@invalid_attrs)
    end

    test "update_sub_task/2 with valid data updates the sub_task" do
      sub_task = sub_task_fixture()
      update_attrs = %{completed: false, description: "some updated description", name: "some updated name"}

      assert {:ok, %SubTask{} = sub_task} = SubTasks.update_sub_task(sub_task, update_attrs)
      assert sub_task.completed == false
      assert sub_task.description == "some updated description"
      assert sub_task.name == "some updated name"
    end

    test "update_sub_task/2 with invalid data returns error changeset" do
      sub_task = sub_task_fixture()
      assert {:error, %Ecto.Changeset{}} = SubTasks.update_sub_task(sub_task, @invalid_attrs)
      assert sub_task == SubTasks.get_sub_task!(sub_task.id)
    end

    test "delete_sub_task/1 deletes the sub_task" do
      sub_task = sub_task_fixture()
      assert {:ok, %SubTask{}} = SubTasks.delete_sub_task(sub_task)
      assert_raise Ecto.NoResultsError, fn -> SubTasks.get_sub_task!(sub_task.id) end
    end

    test "change_sub_task/1 returns a sub_task changeset" do
      sub_task = sub_task_fixture()
      assert %Ecto.Changeset{} = SubTasks.change_sub_task(sub_task)
    end
  end
end
