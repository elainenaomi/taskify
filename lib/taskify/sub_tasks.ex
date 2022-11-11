defmodule Taskify.SubTasks do
  @moduledoc """
  The SubTasks context.
  """

  import Ecto.Query, warn: false
  alias Taskify.Repo

  alias Taskify.SubTasks.SubTask

  @doc """
  Returns the list of sub_tasks.

  ## Examples

      iex> list_sub_tasks()
      [%SubTask{}, ...]

  """
  def list_sub_tasks do
    Repo.all(SubTask)
  end

  @doc """
  Gets a single sub_task.

  Raises `Ecto.NoResultsError` if the Sub task does not exist.

  ## Examples

      iex> get_sub_task!(123)
      %SubTask{}

      iex> get_sub_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sub_task!(id), do: Repo.get!(SubTask, id)

  @doc """
  Creates a sub_task.

  ## Examples

      iex> create_sub_task(%{field: value})
      {:ok, %SubTask{}}

      iex> create_sub_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sub_task(attrs \\ %{}) do
    %SubTask{}
    |> SubTask.changeset(attrs)
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
