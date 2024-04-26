defmodule TimeManagerWeb.WorkingTimeView do
  use TimeManagerWeb, :view
  alias TimeManagerWeb.WorkingTimeView

  def render("index.json", %{workingtimes: workingtimes}) do
    %{data: render_many(workingtimes, WorkingTimeView, "working_time.json")}
  end

  def render("show.json", %{working_time: working_time}) do
    %{data: render_one(working_time, WorkingTimeView, "working_time.json")}
  end

  def render("working_time.json", %{working_time: working_time}) do
    %{
      id: working_time.id,
      start: working_time.start,
      end: working_time.end,
      userid: working_time.user_id
    }
  end

  # def index(%{users: users}) do
  #   %{data: for(user <- users, do: data(user))}
  # end

  # def show(%{user: user}) do
  #   %{data: data(user)}
  # end

  # defp data(%WorkingTime{} = working_time) do
  #   %{
  #     id: user.id,
  #     email: user.email,
  #     username: user.username,
  #     last_name: user.last_name,
  #     first_name: user.first_name
  #   }
  # end
end
