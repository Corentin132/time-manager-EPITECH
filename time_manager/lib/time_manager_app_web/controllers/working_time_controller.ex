defmodule TimeManagerWeb.WorkingTimeController do
  @moduledoc """
  Controller for working time
  """
  use TimeManagerWeb, :controller

  alias TimeManager.Tools
  alias TimeManager.Tools.WorkingTime

  action_fallback TimeManagerWeb.FallbackController

  def index(conn, _params) do
    workingtimes = Tools.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"userid" => userid, "working_time" => working_time_params}) do
    with {:ok, %WorkingTime{} = working_time} <-
           Tools.create_working_time(Map.put(working_time_params, "user_id", userid)) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def show(conn, %{"id" => id, "userid" => userid}) do
    case check(id, userid) do
      error when error in [:error, :not_found, :unauthorized] ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Working time not found."})

      :ok ->
        workingtime = Tools.get_working_time(id)
        render(conn, "show.json", working_time: workingtime)
    end

    # working_time = Tools.get_working_time(id)
    # with {:ok, %WorkingTime{} = working_time} <- Tools.get_working_time(working_time, working_time_params) do
    #   render(conn, "show.json", working_time: working_time)
    # end
  end

  def show_all(conn, %{"userid" => userid}) do
    workingtimes = Tools.get_working_times_for_user(userid)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def show_period(conn, %{"userid" => userid, "start" => starttime, "end" => endtime}) do
    if Utils.valid_uuid?(userid) do
      workingtimes = Tools.get_workingtimes_for_period(userid, starttime, endtime)
      render(conn, "index.json", workingtimes: workingtimes)
    else
      conn
      |> put_status(:not_found)
      |> json(%{error: "User not found."})
    end
  end

  def update(conn, %{"userid" => userid, "id" => id, "working_time" => working_time_params}) do
    case check(id, userid) do
      error when error in [:error, :not_found, :unauthorized] ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Working time not found."})

      :ok ->
        workingtime = Tools.get_working_time(id)
        Tools.update_working_time(workingtime, working_time_params)
        render(conn, "show.json", working_time: workingtime)
    end
  end

  def delete(conn, %{"userid" => userid, "id" => id}) do
    case check(id, userid) do
      error when error in [:error, :not_found, :unauthorized] ->
        conn
        |> put_status(error)
        |> json(%{error: "Working time not found."})

      :ok ->
        workingtime = Tools.get_working_time(id)
        Tools.delete_working_time(workingtime)
        send_resp(conn, :ok, "")
    end
  end

  def delete_all(conn, %{"userid" => userid}) do
    working_times = Tools.get_working_times_for_user(userid)

    for w <- working_times do
      Tools.delete_working_time(w)
    end

    send_resp(conn, :no_content, "")
  end

  defp check(id, user_id) do
    if Utils.valid_uuid?(id) and Utils.valid_uuid?(user_id) do
      case Tools.get_working_time(id) do
        nil ->
          :not_found

        working_time ->
          match_userid(working_time, user_id)
      end
    end
  end

  defp match_userid(working_time, user_id) do
    if working_time.user_id == user_id do
      :ok
    else
      :unauthorized
    end
  end
end
