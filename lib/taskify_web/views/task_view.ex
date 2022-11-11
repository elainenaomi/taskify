defmodule TaskifyWeb.TaskView do
  use TaskifyWeb, :view

  def sub_tasks_status(%{sub_tasks: sub_tasks}) when is_list(sub_tasks) and sub_tasks != [] do
    completed = Enum.count(sub_tasks, & &1.completed)
    total = Enum.count(sub_tasks)

    "#{completed} / #{total}"
  end

  def sub_tasks_status(_), do: "0"
end
