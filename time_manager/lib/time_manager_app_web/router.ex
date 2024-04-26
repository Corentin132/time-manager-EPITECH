defmodule TimeManagerWeb.Router do
  use TimeManagerWeb, :router

  use Plug.ErrorHandler

  import TimeManagerWeb.UserAuth

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:fetch_session)
    plug(:fetch_current_user)
    plug(CORSPlug, origin: ~r/http?:\/\/localhost:d+/)
  end

  # user must be authenticated to acces this routes
  scope "/api", TimeManagerWeb do
    pipe_through([:api, :require_authenticated_user])

    # user
    put("/users/:userid", Accounts.UserController, :update)
    delete("/users/log_out", Accounts.UserController, :log_out)
    get("/user", Accounts.UserController, :show_current)
    delete("/users/:userid", Accounts.UserController, :delete)
    # clock
    get("/clocks/", ClockController, :index)
    get("/clocks/:userid", ClockController, :show)
    post("/clocks/:id", ClockController, :toggle)
    #working time
    get("/", WorkingTimeController, :index)
    get("/:userid", WorkingTimeController, :show_all)
    get("/:userid/:id", WorkingTimeController, :show)
    post("/:userid", WorkingTimeController, :create)
    put("/:userid/:id", WorkingTimeController, :update)
    delete("/:userid/:id", WorkingTimeController, :delete)
    delete("/:userid", WorkingTimeController, :delete_all)
  end

  # user must be admin to acces this routes
  scope "/api", TimeManagerWeb do
    pipe_through([:api, :require_admin_user, :require_authenticated_user])

    put("/admin/:userid", Accounts.UserController, :update_role)
  end

  # if user is authenticated, redirect
  scope "/api", TimeManagerWeb do
    pipe_through([:api, :redirect_if_user_is_authenticated])
    post("/users/log_in", Accounts.UserController, :create)
  end

  # if user is not authenticated
  scope "/api", TimeManagerWeb do
    pipe_through(:api)
    get("/users", Accounts.UserController, :index)
    get("/users/:id", Accounts.UserController, :show)
    post("/users/register", UserRegistrationController, :create)
  end

  scope "/api/manager", TimeManagerWeb do
    pipe_through([:api, :require_authenticated_user])
    get("/:managerid", ManagerController, :index)
    put("/:managerid/:userid", ManagerController, :update)
    delete("/:userid", ManagerController, :reset)
    get("/", ManagerController, :index)
    get("/:managerid", ManagerController, :show)
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{kind: _kind, reason: _reason, stack: _stack}) do
    send_resp(conn, conn.status, "Something went wrong")
  end
end
