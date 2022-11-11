defmodule TaskifyWeb.SubTaskController do
  use TaskifyWeb, :controller

  alias Taskify.{SubTasks, Tasks}
  alias Taskify.SubTasks.SubTask

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_user]
    apply(__MODULE__, action_name(conn), args)
  end

  def index(conn, %{"task_id" => task_id}, current_user) do
    task = Tasks.get_user_task!(current_user, task_id)
    sub_tasks = SubTasks.list_sub_tasks(task)
    render(conn, "index.html", sub_tasks: sub_tasks, task: task)
  end

  def new(conn, %{"task_id" => task_id}, current_user) do
    task = Tasks.get_user_task!(current_user, task_id)
    changeset = SubTasks.change_sub_task(%SubTask{})
    render(conn, "new.html", changeset: changeset, task: task)
  end

end
