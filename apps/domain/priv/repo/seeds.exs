# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Domain.Repo.insert!(%CurrencyConverter.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Comeonin.Bcrypt

# User Admin
Domain.Repo.insert!(
  %Domain.User{
    first_name: "admin",
    last_name: "test",
    email: "admin@converter.ex",
    password_hash: Bcrypt.hashpwsalt("password")
  }
)
