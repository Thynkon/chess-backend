defmodule Chess.VariantsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Chess.Variants` context.
  """

  @doc """
  Generate a variant.
  """
  def variant_fixture(attrs \\ %{}) do
    {:ok, variant} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Chess.Variants.create_variant()

    variant
  end
end
