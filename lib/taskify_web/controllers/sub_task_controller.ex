defmodule TaskifyWeb.SubTaskController do
  use TaskifyWeb, :controller

  alias Taskify.SubTasks
  alias Taskify.SubTasks.SubTask

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, %{"task_id" => task_id}, current_user) do
    sub_tasks = SubTasks.list_user_sub_tasks(current_user, task_id)
    render(conn, "index.html", sub_tasks: sub_tasks, task_id: task_id)
  end

  def new(conn, %{"task_id" => task_id}, _current_user) do
    changeset = SubTasks.change_sub_task(%SubTask{})
    render(conn, "new.html", changeset: changeset, task_id: task_id)
  end

  def create(conn, %{"task_id" => task_id, "sub_task" => sub_task_params}, current_user) do
    case SubTasks.create_sub_task(sub_task_params, current_user, task_id) do
      {:ok, sub_task} ->
        conn
        |> put_flash(:info, "Sub task created successfully.")
        |> redirect(to: Routes.task_sub_task_path(conn, :show, task_id, sub_task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, task_id: task_id)
    end
  end

  def show(conn, %{"task_id" => task_id, "id" => id}, current_user) do
    sub_task = SubTasks.get_user_sub_task!(id, current_user, task_id)
    render(conn, "show.html", sub_task: sub_task, task_id: task_id)
  end

  def edit(conn, %{"task_id" => task_id, "id" => id}, current_user) do
    sub_task = SubTasks.get_user_sub_task!(id, current_user, task_id)
    changeset = SubTasks.change_sub_task(sub_task)
    render(conn, "edit.html", sub_task: sub_task, changeset: changeset, task_id: task_id)
  end

  def update(
        conn,
        %{"task_id" => task_id, "id" => id, "sub_task" => sub_task_params},
        current_user
      ) do
    sub_task = SubTasks.get_user_sub_task!(id, current_user, task_id)

    case SubTasks.update_sub_task(sub_task, sub_task_params) do
      {:ok, sub_task} ->
        conn
        |> put_flash(:info, "Sub task updated successfully.")
        |> redirect(to: Routes.task_sub_task_path(conn, :show, task_id, sub_task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sub_task: sub_task, changeset: changeset, task_id: task_id)
    end
  end

  def delete(conn, %{"task_id" => task_id, "id" => id}, current_user) do
    sub_task = SubTasks.get_user_sub_task!(id, current_user, task_id)
    {:ok, _sub_task} = SubTasks.delete_sub_task(sub_task)

    conn
    |> put_flash(:info, "Sub task deleted successfully.")
    |> redirect(to: Routes.task_sub_task_path(conn, :index, task_id))
  end
end
