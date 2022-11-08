defmodule TaskifyWeb.SubTaskControllerTest do
  use TaskifyWeb.ConnCase

  import Taskify.SubTasksFixtures

  @create_attrs %{completed: true, description: "some description", name: "some name"}
  @update_attrs %{completed: false, description: "some updated description", name: "some updated name"}
  @invalid_attrs %{completed: nil, description: nil, name: nil}

  describe "index" do
    test "lists all sub_tasks", %{conn: conn} do
      conn = get(conn, Routes.sub_task_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Sub tasks"
    end
  end

  describe "new sub_task" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.sub_task_path(conn, :new))
      assert html_response(conn, 200) =~ "New Sub task"
    end
  end

  describe "create sub_task" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sub_task_path(conn, :create), sub_task: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.sub_task_path(conn, :show, id)

      conn = get(conn, Routes.sub_task_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Sub task"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sub_task_path(conn, :create), sub_task: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Sub task"
    end
  end

  describe "edit sub_task" do
    setup [:create_sub_task]

    test "renders form for editing chosen sub_task", %{conn: conn, sub_task: sub_task} do
      conn = get(conn, Routes.sub_task_path(conn, :edit, sub_task))
      assert html_response(conn, 200) =~ "Edit Sub task"
    end
  end

  describe "update sub_task" do
    setup [:create_sub_task]

    test "redirects when data is valid", %{conn: conn, sub_task: sub_task} do
      conn = put(conn, Routes.sub_task_path(conn, :update, sub_task), sub_task: @update_attrs)
      assert redirected_to(conn) == Routes.sub_task_path(conn, :show, sub_task)

      conn = get(conn, Routes.sub_task_path(conn, :show, sub_task))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, sub_task: sub_task} do
      conn = put(conn, Routes.sub_task_path(conn, :update, sub_task), sub_task: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Sub task"
    end
  end

  describe "delete sub_task" do
    setup [:create_sub_task]

    test "deletes chosen sub_task", %{conn: conn, sub_task: sub_task} do
      conn = delete(conn, Routes.sub_task_path(conn, :delete, sub_task))
      assert redirected_to(conn) == Routes.sub_task_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.sub_task_path(conn, :show, sub_task))
      end
    end
  end

  defp create_sub_task(_) do
    sub_task = sub_task_fixture()
    %{sub_task: sub_task}
  end
end
