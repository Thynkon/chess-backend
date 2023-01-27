# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Chess.Repo.insert!(%Chess.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

require Logger

# Statuses
statuses = [
  %{name: "Scheduled", slug: "scheduled"},
  %{name: "On going", slug: "on_going"},
  %{name: "Finished", slug: "finished"},
  %{name: "Archived", slug: "archived"}
]

Enum.each(statuses, fn status ->
  exists = Chess.Statuses.get_status_by_slug(String.to_atom(status[:slug]))
  Logger.debug("GOT STATUS ==> #{inspect(status)}")

  if exists === nil do
    Logger.debug("Going to insert ==> #{inspect(status[:slug])}")
    {:ok, _status} = Chess.Statuses.create_status(status)
  end
end)

# Variants
variants = [
  "Standard",
  "Crazyhouse"
]

Enum.each(variants, fn variant ->
  exists = Chess.Variants.get_variant_by_name(variant)

  if exists === nil do
    {:ok, _variant} = Chess.Variants.create_variant(%{name: variant})
  end
end)

# Game types
game_types = [
  %{name: "Player VS Computer", slug: "pvc"},
  %{name: "Player VS Player", slug: "pvp"}
]

Enum.each(game_types, fn game_type ->
  exists = Chess.GameTypes.get_game_type_by_slug(String.to_atom(game_type[:slug]))

  if exists === nil do
    {:ok, _game_type} = Chess.GameTypes.create_game_type(game_type)
  end
end)
