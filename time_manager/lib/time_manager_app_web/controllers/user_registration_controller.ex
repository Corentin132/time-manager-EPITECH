defmodule TimeManagerWeb.UserRegistrationController do
  use TimeManagerWeb, :controller
  alias TimeManager.Accounts
  alias TimeManagerWeb.UserAuth
  alias TimeManager.Tools

  def create(conn, %{"user" => user_params}) do
    %{"email" => email, "password" => password, "username" => username, "role" => role} =
      user_params

    if role != "admin" do
      if Accounts.get_user_by_email(email) == nil do
        case Accounts.register_user(user_params) do
          {:ok, user} ->
            conn
            |> put_status(200)
            |> json(%{message: "User created successfully."})

            Tools.create_clock(%{
              "user_id" => user.id,
              "time" => DateTime.utc_now(),
              "status" => false
            })

            conn
            |> UserAuth.log_in_user(user)
        end
      end

      json(conn |> put_status(401), %{error: "User already exists."})
    end

    json(conn |> put_status(401), %{error: "Role admin can't be created."})
  end
end
