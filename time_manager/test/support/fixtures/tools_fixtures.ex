defmodule TimeManager.ToolsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TimeManager.Tools` context.
  """

  @doc """
  Generate a working_time.
  """
  def working_time_fixture(attrs \\ %{}) do
    {:ok, working_time} =
      attrs
      |> Enum.into(%{
        start: ~N[2023-11-02 13:51:00],
        end: ~N[2023-11-02 13:51:00]
      })
      |> TimeManager.Tools.create_working_time()

    working_time
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2023-11-02 13:53:00]
      })
      |> TimeManager.Tools.create_clock()

    clock
  end
end
