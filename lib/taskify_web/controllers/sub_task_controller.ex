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

  defp fetch_task(conn, _opts) do
    task = Tasks.get_user_task!(conn.assigns.current_user, conn.params["task_id"])
    assign(conn, :task, task)
  end

end
