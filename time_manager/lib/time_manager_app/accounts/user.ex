defmodule TimeManager.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias TimeManager.Accounts.User, as: User

  @moduledoc """
  The User schema.
  """
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field(:email, :string)
    field(:password, :string, virtual: true, redact: true)
    field(:username, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:role, :string, default: "user")
    field(:hashed_password, :string, redact: true)
    field(:confirmed_at, :naive_datetime)
    field(:daily_target, :integer, default: 7)
    field(:weekly_target, :integer, default: 35)
    belongs_to(:manager, User, foreign_key: :manager_id, type: :binary_id)

    timestamps()
  end

  @int_regex ~r/\A\d+\z/
  @uuid_regex ~r/\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/

  def changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email, :password, :username, :first_name, :last_name])
    |> validate_required([:email, :username, :first_name, :last_name, :manager_of])
    |> validate_format(:username, ~r/^[a-zA-Z0-9_]+$/,
      message: "can only contain letters, numbers, and underscores"
    )
    |> validate_length(:username, min: 3, max: 20)
    |> validate_format(:first_name, ~r/^[a-zA-Z]+$/, message: "can only contain letters")
    |> validate_format(:last_name, ~r/^[a-zA-Z]+$/, message: "can only contain letters")
    |> validate_email()
    |> validate_password(opts)
  end

  def role_changeset(user, attrs \\ []) do
    user
    |> cast(attrs, [:role, :email, :username, :first_name, :last_name])
    |> validate_inclusion(:role, ["user", "manager", "admin"])
    |> validate_format(:username, ~r/^[a-zA-Z0-9_]+$/,
      message: "can only contain letters, numbers, and underscores"
    )
    |> validate_length(:username, min: 3, max: 20)
    |> validate_format(:first_name, ~r/^[a-zA-Z]+$/, message: "can only contain letters")
    |> validate_format(:last_name, ~r/^[a-zA-Z]+$/, message: "can only contain letters")
    |> validate_email()
  end

  @doc """
  A user changeset for registration.

  It is important to validate the length of both email and password.
  Otherwise databases may truncate the email without warnings, which
  could lead to unpredictable or insecure behaviour. Long passwords may
  also be very expensive to hash for certain algorithms.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def registration_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email, :password, :username, :first_name, :last_name, :role])
    |> validate_format(:username, ~r/^[a-zA-Z0-9_]+$/,
      message: "can only contain letters, numbers, and underscores"
    )
    |> validate_length(:username, min: 3, max: 20)
    |> validate_format(:first_name, ~r/^[a-zA-Z]+$/, message: "can only contain letters")
    |> validate_format(:last_name, ~r/^[a-zA-Z]+$/, message: "can only contain letters")
    |> validate_inclusion(:role, ["user", "manager", "admin"])
    |> validate_password(opts)
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
  end

  defp validate_password(changeset, opts) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 12, max: 72)
    # |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    # |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    # |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/, message: "at least one digit or punctuation character")
    |> maybe_hash_password(opts)
  end

  defp maybe_hash_password(changeset, opts) do
    hash_password? = Keyword.get(opts, :hash_password, true)
    password = get_change(changeset, :password)

    if hash_password? && password && changeset.valid? do
      changeset
      # If using Bcrypt, then further validate it is at most 72 bytes long
      |> validate_length(:password, max: 72, count: :bytes)
      |> put_change(:hashed_password, Bcrypt.hash_pwd_salt(password))
      |> delete_change(:password)
    else
      changeset
    end
  end

  @doc """
  A user changeset for changing the email.

  It requires the email to change otherwise an error is added.
  """
  def email_changeset(user, attrs) do
    user
    |> cast(attrs, [:email])
    |> validate_email()
    |> case do
      %{changes: %{email: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :email, "did not change")
    end
  end

  def daily_target_changeset(user, attrs) do
    user
    |> cast(attrs, [:daily_target])
    |> validate_required([:daily_target])
    |> validate_format(:daily_target, @int_regex)
    |> validate_number(:daily_target, greater_than_or_equal_to: 0)
    |> validate_number(:daily_target, less_than_or_equal_to: 11)
    |> validate_number(:daily_target, less_than_or_equal_to: user.weekly_target)
    |> case do
      %{changes: %{daily_target: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :daily_target, "did not change")
    end
  end

  def weekly_target_changeset(user, attrs) do
    user
    |> cast(attrs, [:weekly_target])
    |> validate_required([:weekly_target])
    |> validate_format(:daily_target, @int_regex)
    |> validate_number(:weekly_target, greater_than_or_equal_to: 0)
    |> validate_number(:weekly_target, less_than_or_equal_to: 70)
    |> case do
      %{changes: %{weekly_target: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :weekly_target, "did not change")
    end
  end

  def manager_id_changeset(user, attrs) do
    user
    |> cast(attrs, [:manager_id])
    |> validate_required([:manager_id])
    |> validate_format(:manager_id, @uuid_regex)
    |> case do
      %{changes: %{manager_id: _}} = changeset -> changeset
      %{} = changeset -> add_error(changeset, :manager_id, "did not change")
    end
  end

  def reset_manager_id_changeset(user) do
    user
    |> cast(%{manager_id: nil}, [:manager_id], clear: true)
  end

  @doc """
  A user changeset for changing the password.

  ## Options

    * `:hash_password` - Hashes the password so it can be stored securely
      in the database and ensures the password field is cleared to prevent
      leaks in the logs. If password hashing is not needed and clearing the
      password field is not desired (like when using this changeset for
      validations on a LiveView form), this option can be set to `false`.
      Defaults to `true`.
  """
  def password_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:password])
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_password(opts)
  end

  @doc """
  Confirms the account by setting `confirmed_at`.
  """
  def confirm_changeset(user) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    change(user, confirmed_at: now)
  end

  @doc """
  Verifies the password.

  If there is no user or the user doesn't have a password, we call
  `Bcrypt.no_user_verify/0` to avoid timing attacks.
  """
  def valid_password?(%TimeManager.Accounts.User{hashed_password: hashed_password}, password)
      when is_binary(hashed_password) and byte_size(password) > 0 do
    Bcrypt.verify_pass(password, hashed_password)
  end

  def valid_password?(_, _) do
    Bcrypt.no_user_verify()
    false
  end

  @doc """
  Validates the current password otherwise adds an error to the changeset.
  """
  def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end
end
