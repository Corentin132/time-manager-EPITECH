# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TimeManager.Repo.insert!(%TimeManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TimeManager.Accounts
alias TimeManager.Tools

user_data = [
  %{
    email: "fh@example.com",
    password: "jesuissecret",
    username: "Flambie",
    first_name: "Francois",
    last_name: "Hollande",
    role: "manager"
  },
  %{
    email: "ns@example.com",
    password: "jesuissecret",
    username: "Lenain",
    first_name: "Nicolas",
    last_name: "Sarkozi",
    role: "admin"
  },
  %{
    email: "jc@example.com",
    password: "jesuissecret",
    username: "5mindouchecomprise",
    first_name: "Jacques",
    last_name: "Chirac",
    role: "user"
  }
]

Enum.each(user_data, fn data ->
  Accounts.register_user(data)
  user = Accounts.get_user_by_email_and_password(data.email, data.password)
  Tools.create_clock(%{"user_id" => user.id, "time" => DateTime.utc_now(), "status" => false})
end)
