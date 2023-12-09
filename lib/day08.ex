defmodule Day08 do
  def parse_input(input) do
    [directions, elements] = input |> String.split("\n\n")

    element_map =
      elements
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [label, nodes] = String.split(line, " = ")
        nodes = nodes |> String.replace(["(", ")", " "], "") |> String.split(",")
        {label, nodes}
      end)
      |> Map.new()

    directions =
      directions
      |> String.split("", trim: true)
      |> Enum.map(fn
        "L" -> 0
        "R" -> 1
      end)

    {directions, element_map}
  end

  def find_zzz(_, _, _, _, steps \\ 0)
  def find_zzz(_, _, "ZZZ", _, steps), do: steps

  def find_zzz([direction | rem_directions], starting_dirs, element_key, element_map, steps) do
    element = Map.fetch!(element_map, element_key)
    new_el_key = Enum.at(element, direction)

    directions = if rem_directions === [], do: starting_dirs, else: rem_directions

    find_zzz(
      directions,
      starting_dirs,
      new_el_key,
      element_map,
      steps + 1
    )
  end

  def pt1(input) do
    {directions, element_map} =
      input
      |> parse_input

    find_zzz(directions, directions, "AAA", element_map)
  end

  def find_ends_with_z(_, _, _, _, steps \\ 0)

  def find_ends_with_z(
        [direction | rem_directions],
        starting_dirs,
        element_key,
        element_map,
        steps
      ) do
    directions = if rem_directions === [], do: starting_dirs, else: rem_directions
    new_key = Map.fetch!(element_map, element_key) |> Enum.at(direction)

    ends_in_z = String.split(new_key, "", trim: true) |> List.last() === "Z"

    cond do
      ends_in_z ->
        steps + 1

      true ->
        find_ends_with_z(
          directions,
          starting_dirs,
          new_key,
          element_map,
          steps + 1
        )
    end
  end

  def pt2(input) do
    {directions, element_map} =
      input
      |> parse_input

    starting_keys =
      Enum.reduce(
        element_map,
        [],
        fn {label, _}, nodes ->
          case String.split(label, "", trim: true) do
            [_, _, "A"] -> [label | nodes]
            _ -> nodes
          end
        end
      )

    # get the lowest common multiple of all the step counts
    for key <- starting_keys, reduce: 1 do
      lcm ->
        Math.lcm(find_ends_with_z(directions, directions, key, element_map), lcm)
    end
  end
end
