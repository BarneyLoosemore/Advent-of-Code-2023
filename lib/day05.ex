defmodule Day05 do
  def pass_through_mappers([], location), do: location

  def pass_through_mappers([map | mappers], seed) do
    output = pass_through_map(map, seed)
    pass_through_mappers(mappers, output)
  end

  def pass_through_map([], input), do: input

  def pass_through_map([[dest, source, range] | _], input)
      when source <= input and input < source + range,
      do: input + (dest - source)

  def pass_through_map([_ | lines], input), do: pass_through_map(lines, input)

  defp format_seeds(seeds), do: seeds |> String.split(" ") |> Enum.map(&String.to_integer/1)

  defp format_mappers(maps),
    do:
      maps
      |> Enum.map(&(&1 |> String.split("\n", trim: true)))
      |> Enum.map(
        &(&1
          |> Enum.map(fn line ->
            line |> String.split(" ") |> Enum.map(fn char -> String.to_integer(char) end)
          end))
      )

  defp format_input(input) do
    [seeds | mappers] =
      input
      |> String.split("\n\n", trim: true)
      |> Enum.map(&(&1 |> String.split([":", ": "], trim: true) |> Enum.at(1)))

    [format_seeds(seeds), format_mappers(mappers)]
  end

  def pt2(input) do
    [seeds, mappers] = format_input(input)

    seeds
    |> Enum.chunk_every(2)
    |> Enum.map(fn [start_seed, range] ->
      Enum.to_list(start_seed..(start_seed + range - 1))
      |> Enum.map(&pass_through_mappers(mappers, &1))
    end)
    |> List.flatten()
    |> Enum.min()
  end

  def pt1(input) do
    [seeds, mappers] = format_input(input)
    seeds |> Enum.map(&pass_through_mappers(mappers, &1)) |> Enum.min()
  end
end
