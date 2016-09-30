# Showcase01

A test umbrella app written in Elixir, includes Phoenix as dependency.

## Installation instructions for development

1. Install Erlang and Elixir
2. Install postgres, make sure that you have user `postgres` with the same password so he can create the development database.
3. Clone this project.
4. Use the following commands to install the dependencies
   ```
   cd showcase01
   mix deps.get
   mix ecto.migrate
   ```
5. Run server with `mix phoenix.server`. You can also use `iex -S mix phoenix.server` to access the command line.

