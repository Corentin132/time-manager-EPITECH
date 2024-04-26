defmodule TimeManagerWeb.UserResetPasswordController do
  use TimeManagerWeb, :controller

  alias TimeManager.Accounts

  plug(:get_user_by_reset_password_token when action in [:edit, :update])

  def new(conn, _params) do
    render(conn)
  end

  def edit(conn, _params) do
    render(conn, changeset: Accounts.change_user_password(conn.assigns.user))
  end

  # Do not log in the user after reset password to avoid a
  # leaked token giving the user access to the account.
  def update(conn, %{"user" => user_params}) do
    case Accounts.reset_user_password(conn.assigns.user, user_params) do
      {:ok, _} ->
        conn
        |> json(%{message: "Password reset successfully."})

      # |> redirect(to: Routes.user_session_path(conn, :new))

      {:error, changeset} ->
        render(conn, changeset: changeset)
    end
  end

  defp get_user_by_reset_password_token(conn, _opts) do
    %{"token" => token} = conn.params

    if user = Accounts.get_user_by_reset_password_token(token) do
      conn |> assign(:user, user) |> assign(:token, token)
    else
      conn
      |> json(%{message: "Invalid token."})
      |> redirect(to: "/")
      |> halt()
    end
  end
end
