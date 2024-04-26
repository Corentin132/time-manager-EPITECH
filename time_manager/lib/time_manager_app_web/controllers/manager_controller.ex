defmodule TimeManagerWeb.ManagerController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts
  alias TimeManagerWeb.Accounts.UserJSON
  action_fallback(TimeManagerWeb.FallbackController)

  def index(conn, _params) do
    managers = Accounts.list_managers()
    json(conn, UserJSON.index(%{users: managers}))
  end

  def show(conn, %{"managerid" => manager_id}) do
    with {:ok, users} <- Accounts.list_managed_users(manager_id) do
      json(conn, UserJSON.index(%{users: users}))
    else
      _ -> send_resp(conn, :not_found, "No users found")
    end
  end

  def update(conn, %{"managerid" => manager_id, "userid" => user_id}) do
    try do
      case Accounts.get_user(manager_id) do
        nil ->
          send_resp(conn, :not_found, "Manager not found  ")

        manager ->
          if is_manager(manager) do
            case Accounts.get_user(user_id) do
              nil ->
                send_resp(conn, :not_found, "User not found")

              user ->
                case Accounts.update_manager_id(user, %{"manager_id" => manager.id}) do
                  {:ok, updated_user} ->
                    json(conn, UserJSON.show(%{user: updated_user}))

                  _ ->
                    json(conn, %{message: "Update failed"})
                end
            end
          else
            send_resp(conn, :not_found, "Not a manager")
          end
      end
    catch
      _ -> json(conn, %{message: "error"})
    end
  end

  def is_manager(manager) do
    manager.role == "manager"
  end

  def reset(conn, %{"userid" => user_id}) do
    user = Accounts.get_user!(user_id)

    case Accounts.reset_manager_id(user) do
      {:ok, updated_user} ->
        json(conn, UserJSON.show(%{user: updated_user}))

      _ ->
        json(conn, %{message: "error"})
    end
  end
end
