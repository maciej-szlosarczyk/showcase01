defmodule Domain.Factory do
  use ExMachina.Ecto, repo: Domain.Repo

  def user_factory do
    %Domain.User{email: "admin@test.com", first_name: "Admin",
                  last_name: "Test", password: "password"}
  end
end
