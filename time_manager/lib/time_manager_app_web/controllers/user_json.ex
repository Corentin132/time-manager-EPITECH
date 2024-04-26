defmodule TimeManagerWeb.Accounts.UserJSON do
  alias TimeManager.Accounts.User

  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      email: user.email,
      username: user.username,
      last_name: user.last_name,
      first_name: user.first_name,
      role: user.role,
      daily_target: user.daily_target,
      weekly_target: user.weekly_target,
      manager_id: user.manager_id
    }
  end
end
