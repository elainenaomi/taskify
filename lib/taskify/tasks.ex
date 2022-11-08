defmodule Taskify.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias Taskify.Accounts
  alias Taskify.Repo

  alias Taskify.Tasks.Task

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_user_tasks(user)
      [%Task{}, ...]

  """
  def list_user_tasks(user) do
    Task
    |> user_tasks_query(user)
    |> Repo.all()
  end

  defp user_tasks_query(query, %Accounts.User{id: user_id}) do
    from(t in query,
      left_join: s in assoc(t, :sub_tasks),
      where: t.user_id == ^user_id,
      preload: [:user, sub_tasks: s]
    )
  end

  @doc """
  Gets a single task from a given user

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_user_task!(user, 123)
      %Task{}

      iex> get_user_task!(user, 456)
      ** (Ecto.NoResultsError)

  """
  def get_user_task!(user, id) do
    Task
    |> user_tasks_query(user)
    |> Repo.get!(id)
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(user, %{field: value})
      {:ok, %Task{}}

      iex> create_task(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(%Accounts.User{} = user, attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
