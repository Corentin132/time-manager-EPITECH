defmodule TimeManagerWeb.Accounts.UserController do
  use TimeManagerWeb, :controller
  alias TimeManager.Accounts
  alias TimeManagerWeb.Accounts.UserJSON
  alias TimeManagerWeb.UserAuth

  # list all users
  def index(conn, _params) do
    users = Accounts.list_users()

    json(conn, UserJSON.index(%{users: users}))
  end

  # find user by id
  def show(conn, %{"id" => id}) do
    if match?({:ok, _}, Ecto.UUID.dump(id)) do
      user = Accounts.get_user(id)

      if user != nil do
        json(conn, UserJSON.show(%{user: user}))
      else
        conn
        |> put_status(404)
        |> json(%{error: "User not found."})
      end
    else
      conn
      |> put_status(404)
      |> json(%{error: "A error has occurred."})
    end
  end

  # log in user
  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password} = user_params

    if user = Accounts.get_user_by_email_and_password(email, password) do
      UserAuth.log_in_user(conn, user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      json(conn |> put_status(401), %{error: "Invalid email or password."})
    end
  end

  #  log out user
  def log_out(conn, _params) do
    conn
    |> UserAuth.log_out_user()
    |> json(%{message: "Logged out successfully."})
  end

  # update user
  def update(conn, %{"userid" => id}) do
    user_params = conn.body_params["user"]

    if match?({:ok, _}, Ecto.UUID.dump(id)) do
      user = Accounts.get_user(id)

      if user.email == user_params["email"] do
        case Accounts.update_user(user, user_params) do
          {:ok, user} ->
            conn
            |> put_status(200)
            |> json(%{message: "User update successfully."})
        end
      end
    end

    conn
    |> put_status(404)
    |> json(%{error: "User not found."})
  end

  def show_current(conn, _params) do
    user = conn.assigns[:current_user]

    if user != nil do
      json(conn, UserJSON.show(%{user: user}))
    end

    conn
    |> put_status(404)
    |> json(%{error: "User not found."})
  end

  # def add_user_to_manager(conn, %{"user" => user_params}) do
  #   %{"email" => _email, "password" => _password} = user_params
  #   token = get_session(conn, :user_token)
  #   Accounts.update_user(token, user_params)
  # end

  def change_daily_target(conn, %{"user" => user_params}) do
    token = get_session(conn, :user_token)

    case Accounts.update_daily_target(token, user_params) do
      {:ok, _changeset} ->
        conn
        |> put_status(:ok)

      # |> json(UserJSON.show(%{user: user_params}))
      {:error, _} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Invalid daily target."})
    end
  end

  def change_weekly_target(conn, %{"user" => user_params}) do
    token = get_session(conn, :user_token)

    case Accounts.update_weekly_target(token, user_params) do
      {:ok, _changeset} ->
        conn
        |> put_status(:ok)

      # |> json(UserJSON.show(%{user: user_params}))
      {:error, _} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: "Invalid weekly target."})
    end
  end

  def delete(conn, %{"userid" => id}) do
    if match?({:ok, _}, Ecto.UUID.dump(id)) do
      user = Accounts.get_user(id)

      if user != nil do
        Accounts.delete_user(user)
        json(conn, %{message: "User deleted successfully."})
      end
    end

    conn
    |> put_status(404)
    |> json(%{error: "User not found."})
  end

  def update_role(conn, %{"userid" => id}) do
    role = conn.body_params["role"]

    if match?({:ok, _}, Ecto.UUID.dump(id)) do
      user = Accounts.get_user(id)

      if user != nil do
        Accounts.update_user_role(user, role)
        json(conn, %{message: "User role updated successfully."})
      end
    end

    conn
    |> put_status(404)
    |> json(%{error: "User not found."})
  end
end
