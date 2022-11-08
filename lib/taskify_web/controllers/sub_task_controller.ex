defmodule TaskifyWeb.SubTaskController do
  use TaskifyWeb, :controller

  alias Taskify.SubTasks
  alias Taskify.SubTasks.SubTask

  def index(conn, _params) do
    sub_tasks = SubTasks.list_sub_tasks()
    render(conn, "index.html", sub_tasks: sub_tasks)
  end

  def new(conn, _params) do
    changeset = SubTasks.change_sub_task(%SubTask{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sub_task" => sub_task_params}) do
    case SubTasks.create_sub_task(sub_task_params) do
      {:ok, sub_task} ->
        conn
        |> put_flash(:info, "Sub task created successfully.")
        |> redirect(to: Routes.sub_task_path(conn, :show, sub_task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sub_task = SubTasks.get_sub_task!(id)
    render(conn, "show.html", sub_task: sub_task)
  end

  def edit(conn, %{"id" => id}) do
    sub_task = SubTasks.get_sub_task!(id)
    changeset = SubTasks.change_sub_task(sub_task)
    render(conn, "edit.html", sub_task: sub_task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sub_task" => sub_task_params}) do
    sub_task = SubTasks.get_sub_task!(id)

    case SubTasks.update_sub_task(sub_task, sub_task_params) do
      {:ok, sub_task} ->
        conn
        |> put_flash(:info, "Sub task updated successfully.")
        |> redirect(to: Routes.sub_task_path(conn, :show, sub_task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sub_task: sub_task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sub_task = SubTasks.get_sub_task!(id)
    {:ok, _sub_task} = SubTasks.delete_sub_task(sub_task)

    conn
    |> put_flash(:info, "Sub task deleted successfully.")
    |> redirect(to: Routes.sub_task_path(conn, :index))
  end
end
