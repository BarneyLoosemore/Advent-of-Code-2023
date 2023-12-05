defmodule Day02 do
  defp get_games(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(
      &(String.split(&1, ":")
        |> Enum.at(1)
        |> String.trim()
        |> String.split(["; ", ", "])
        |> Enum.map(fn play ->
          [cubes, day] = String.split(play, " ")
          [String.to_integer(cubes), day]
        end))
    )
  end

  defp find_possible_games(games) do
    games
    |> Enum.with_index()
    |> Enum.map(fn {game, idx} ->
      game
      |> Enum.reduce_while(
        idx + 1,
        fn [cubes, colour], game_id ->
          case [cubes, colour] do
            [cubes, "red"] when cubes > 12 -> {:halt, 0}
            [cubes, "green"] when cubes > 13 -> {:halt, 0}
            [cubes, "blue"] when cubes > 14 -> {:halt, 0}
            _ -> {:cont, game_id}
          end
        end
      )
    end)
  end

  defp find_max_plays(games) do
    games
    |> Enum.map(
      &(Enum.reduce(
          &1,
          %{"red" => 0, "green" => 0, "blue" => 0},
          fn [cubes, colour], acc ->
            cond do
              cubes > acc[colour] -> %{acc | colour => cubes}
              true -> acc
            end
          end
        )
        |> Map.values()
        |> Enum.product())
    )
  end

  def pt1(input), do: input |> get_games |> find_possible_games |> Enum.sum()
  def pt2(input), do: input |> get_games |> find_max_plays |> Enum.sum()
end
