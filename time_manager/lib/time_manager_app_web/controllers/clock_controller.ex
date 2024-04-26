defmodule TimeManagerWeb.ClockController do
  @moduledoc """
  Controller for clock
  """

  use TimeManagerWeb, :controller

  alias TimeManager.Tools
  # alias TimeManager.Tools.Clock

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Tools.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def toggle(conn, %{"id" => user_id}) do
    case Tools.get_clock_by_userid(user_id) do
      nil ->
        conn
        |> send_resp(:not_found, "Clock not found")

        IO.puts("ERROORR")

      clock ->
        case clock.status do
          false ->
            clock_params = %{
              "status" => true,
              "time" => DateTime.utc_now()
            }

            with {:ok, updated_clock} <- Tools.update_clock(clock, clock_params) do
              conn
              |> render("show.json", clock: updated_clock)
            end

          true ->
            working_time_params = %{
              "start" => clock.time,
              "end" => DateTime.utc_now(),
              "user_id" => user_id
            }

            Tools.create_working_time(working_time_params)

            with {:ok, updated_clock} <- Tools.update_clock(clock, %{"status" => false}) do
              conn
              |> render("show.json", clock: updated_clock)
            end
        end
    end
  end

  def show(conn, %{"userid" => user_id}) do
    clock = Tools.get_clock_by_userid(user_id)
    render(conn, "show.json", clock: clock)
  end

end
