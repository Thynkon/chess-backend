#!/bin/bash

set -e

# Ensure the app's dependencies are installed
mix deps.get

# Compile dependencies
mix deps.compile

# Create database and run migrations
mix ecto.create
mix ecto.migrate

mix run priv/repo/seeds.exs

# Launch Elixir's remote session
elixir --name docker@172.60.0.2 --cookie exchess -S mix phx.server
