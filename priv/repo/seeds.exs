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

# Statuses
{:ok, _status} = Chess.Statuses.create_status(%{name: "Scheduled", slug: "scheduled"})
{:ok, _status} = Chess.Statuses.create_status(%{name: "On going", slug: "on_going"})
{:ok, _status} = Chess.Statuses.create_status(%{name: "Finished", slug: "finished"})
{:ok, _status} = Chess.Statuses.create_status(%{name: "Archived", slug: "archived"})

# Variants
{:ok, _variant} = Chess.Variants.create_variant(%{name: "Standard"})
{:ok, _variant} = Chess.Variants.create_variant(%{name: "Crazyhouse"})

# Game types
{:ok, _game_type} = Chess.GameTypes.create_game_type(%{name: "Player VS Computer", slug: "pvc"})
{:ok, _game_type} = Chess.GameTypes.create_game_type(%{name: "Player VS Player", slug: "pvp"})
