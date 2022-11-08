defmodule Taskify.SubTasks do
  @moduledoc """
  The SubTasks context.
  """

  import Ecto.Query, warn: false
  alias Taskify.Repo

  alias Taskify.{Accounts, Tasks}
  alias Taskify.SubTasks.SubTask
  alias Taskify.Tasks.Task

  @doc """
  Returns the list of sub_tasks.

  ## Examples

      iex> list_user_sub_tasks(user, task_id)
      [%SubTask{}, ...]

  """
  def list_user_sub_tasks(%Accounts.User{} = user, task_id) do
    SubTask
    |> user_tasks_sub_task_query(user, task_id)
    |> Repo.all()
  end

  defp user_tasks_sub_task_query(query, %Accounts.User{id: user_id}, task_id) do
    from(s in query,
      join: t in Task,
      on: t.id == s.task_id,
      where: s.task_id == ^task_id and t.user_id == ^user_id
    )
  end

  @doc """
  Gets a single sub_task.

  Raises `Ecto.NoResultsError` if the Sub task does not exist.

  ## Examples

      iex> get_user_sub_task!(123)
      %SubTask{}

      iex> get_user_sub_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_sub_task!(id, user, task_id) do
    SubTask
    |> user_tasks_sub_task_query(user, task_id)
    |> Repo.get!(id)
  end

  @doc """
  Creates a sub_task.

  ## Examples

      iex> create_sub_task(%{field: value}, user, task_id)
      {:ok, %SubTask{}}

      iex> create_sub_task(%{field: bad_value}, user, task_id)
      {:error, %Ecto.Changeset{}}

  """
  def create_sub_task(attrs \\ %{}, %Accounts.User{} = user, task_id) do
    task = Tasks.get_user_task!(user, task_id)

    %SubTask{}
    |> SubTask.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:task, task)
    |> Repo.insert()
  end

  @doc """
  Updates a sub_task.

  ## Examples

      iex> update_sub_task(sub_task, %{field: new_value})
      {:ok, %SubTask{}}

      iex> update_sub_task(sub_task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sub_task(%SubTask{} = sub_task, attrs) do
    sub_task
    |> SubTask.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sub_task.

  ## Examples

      iex> delete_sub_task(sub_task)
      {:ok, %SubTask{}}

      iex> delete_sub_task(sub_task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sub_task(%SubTask{} = sub_task) do
    Repo.delete(sub_task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sub_task changes.

  ## Examples

      iex> change_sub_task(sub_task)
      %Ecto.Changeset{data: %SubTask{}}

  """
  def change_sub_task(%SubTask{} = sub_task, attrs \\ %{}) do
    SubTask.changeset(sub_task, attrs)
  end
end
