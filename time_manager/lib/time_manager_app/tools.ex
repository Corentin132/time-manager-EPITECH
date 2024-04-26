defmodule TimeManager.Tools do
  @moduledoc """
  The Tools context.
  """

  import Ecto.Query, warn: false
  alias TimeManager.Repo
  alias ElixirSense.Plugins.Ecto.UUID
  alias TimeManager.Tools.WorkingTime

  @doc """
  Returns the list of workingtimes.

  ## Examples

      iex> list_workingtimes()
      [%WorkingTime{}, ...]

  """
  def list_workingtimes do
    query =
      from(w in WorkingTime, select: %{id: w.id, start: w.start, end: w.end, user_id: w.user_id})

    Repo.all(query)
    # Repo.all(WorkingTime)
  end

  @doc """
  Gets a single working_time.

  Raises `Ecto.NoResultsError` if the Working time does not exist.

  ## Examples

      iex> get_working_time(123)
      %WorkingTime{}

      iex> get_working_time(456)
      ** (Ecto.NoResultsError)

  """
  def get_working_time(id) do
    if Utils.valid_uuid?(id) do
      Repo.get(WorkingTime, id)
    else
      nil
    end
  end

  def get_working_times_for_user(userid) do
    query =
      from(w in WorkingTime,
        where: w.user_id == ^userid,
        select: %{id: w.id, start: w.start, end: w.end, user_id: w.user_id}
      )

    res = Repo.all(query)
    res
  end

  def get_workingtimes_for_period(userid, starttime, endtime) do
    query =
      from(w in WorkingTime,
        where: w.user_id == ^userid and w.start >= ^starttime and w.end <= ^endtime,
        select: %{id: w.id, start: w.start, end: w.end, user_id: w.user_id}
      )

    Repo.all(query)
  end

  @doc """
  Creates a working_time.

  ## Examples

      iex> create_working_time(%{field: value})
      {:ok, %WorkingTime{}}

      iex> create_working_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_working_time(attrs \\ %{}) do
    %WorkingTime{}
    |> WorkingTime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a working_time.

  ## Examples

      iex> update_working_time(working_time, %{field: new_value})
      {:ok, %WorkingTime{}}

      iex> update_working_time(working_time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_working_time(%WorkingTime{} = working_time, attrs) do
    working_time
    |> WorkingTime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a working_time.

  ## Examples

      iex> delete_working_time(working_time)
      {:ok, %WorkingTime{}}

      iex> delete_working_time(working_time)
      {:error, %Ecto.Changeset{}}

  """
  def delete_working_time(%WorkingTime{} = working_time) do
    Repo.delete(working_time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking working_time changes.

  ## Examples

      iex> change_working_time(working_time)
      %Ecto.Changeset{data: %WorkingTime{}}

  """
  def change_working_time(%WorkingTime{} = working_time, attrs \\ %{}) do
    WorkingTime.changeset(working_time, attrs)
  end

  alias TimeManager.Tools.Clock

  @doc """
  Returns the list of clocks.

  ## Examples

      iex> list_clocks()
      [%Clock{}, ...]

  """
  def list_clocks do
    Repo.all(Clock)
  end

  @doc """
  Gets a single clock.

  Raises `Ecto.NoResultsError` if the Clock does not exist.

  ## Examples

      iex> get_clock(123)
      %Clock{}

      iex> get_clock(456)
      ** (Ecto.NoResultsError)

  """
  def get_clock(id), do: Repo.get(Clock, id)

  def get_clock_by_userid(userid) do
    case Utils.valid_uuid?(userid) do
      true -> Repo.get_by(Clock, user_id: userid)
      false -> nil
    end
  end

  @doc """
  Creates a clock.

  ## Examples

      iex> create_clock(%{field: value})
      {:ok, %Clock{}}

      iex> create_clock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clock(attrs \\ %{}) do
    %Clock{}
    |> Clock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clock.

  ## Examples

      iex> update_clock(clock, %{field: new_value})
      {:ok, %Clock{}}

      iex> update_clock(clock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clock(%Clock{} = clock, attrs) do
    clock
    |> Clock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clock.

  ## Examples

      iex> delete_clock(clock)
      {:ok, %Clock{}}

      iex> delete_clock(clock)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clock(%Clock{} = clock) do
    Repo.delete(clock)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clock changes.

  ## Examples

      iex> change_clock(clock)
      %Ecto.Changeset{data: %Clock{}}

  """
  def change_clock(%Clock{} = clock, attrs \\ %{}) do
    Clock.changeset(clock, attrs)
  end
end
