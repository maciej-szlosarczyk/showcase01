defmodule Web.GuardianSerializer do
  @moduledoc false

  @behaviour Guardian.Serializer

  alias Domain.{User, Users}

  def for_token(user = %User{}), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("User:" <> id), do: {:ok, Users.find_by_params(id: id)}
  def from_token(_), do: {:error, "Unknown resource type"}
end
