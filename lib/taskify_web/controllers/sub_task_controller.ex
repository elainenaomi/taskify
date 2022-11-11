defmodule TaskifyWeb.SubTaskController do
  use TaskifyWeb, :controller

  alias Taskify.{SubTasks, Tasks}
  alias Taskify.SubTasks.SubTask

  plug :fetch_task

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.task]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, %{"task_id" => _task_id}, task) do
    sub_tasks = SubTasks.list_sub_tasks(task)
    render(conn, "index.html", sub_tasks: sub_tasks, task: task)
  end

  def new(conn, %{"task_id" => _task_id}, task) do
    changeset = SubTasks.change_sub_task(%SubTask{})
    render(conn, "new.html", changeset: changeset, task: task)
  end

  def create(conn, %{"task_id" => _task_id, "sub_task" => sub_task_params}, task) do
    case SubTasks.create_sub_task(task, sub_task_params) do
      {:ok, sub_task} ->
        conn
        |> put_flash(:info, "Sub task created successfully.")
        |> redirect(to: Routes.task_sub_task_path(conn, :show, task, sub_task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, task: task)
    end
  end

  def show(conn, %{"task_id" => _task_id, "id" => id}, task) do
    sub_task = SubTasks.get_sub_task!(task, id)
    render(conn, "show.html", sub_task: sub_task, task: task)
  end

  def edit(conn, %{"task_id" => _task_id, "id" => id}, task) do
    sub_task = SubTasks.get_sub_task!(task, id)
    changeset = SubTasks.change_sub_task(sub_task)
    render(conn, "edit.html", sub_task: sub_task, changeset: changeset, task: task)
  end

  def update(
        conn,
        %{"task_id" => _task_id, "id" => id, "sub_task" => sub_task_params},
        task
      ) do
    sub_task = SubTasks.get_sub_task!(task, id)

    case SubTasks.update_sub_task(sub_task, sub_task_params) do
      {:ok, sub_task} ->
        conn
        |> put_flash(:info, "Sub task updated successfully.")
        |> redirect(to: Routes.task_sub_task_path(conn, :show, task, sub_task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sub_task: sub_task, changeset: changeset, task: task)
    end
  end

  def delete(conn, %{"task_id" => _task_id, "id" => id}, task) do
    sub_task = SubTasks.get_sub_task!(task, id)
    {:ok, _sub_task} = SubTasks.delete_sub_task(sub_task)

    conn
    |> put_flash(:info, "Sub task deleted successfully.")
    |> redirect(to: Routes.task_sub_task_path(conn, :index, task))
  end

  defp fetch_task(conn, _opts) do
    task = Tasks.get_user_task!(conn.assigns.current_user, conn.params["task_id"])
    assign(conn, :task, task)
  end
end
