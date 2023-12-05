defmodule Day03 do
  defp create_checklist(idx, line_len, len) do
    above = (idx - line_len - 1)..(idx - line_len + len) |> Enum.to_list()
    below = (idx + line_len - 1)..(idx + line_len + len) |> Enum.to_list()
    left = [idx - 1]
    right = [idx + len]
    [above, left, right, below] |> List.flatten() |> Enum.filter(&(&1 >= 0))
  end

  def pt2(input) do
    lines = input |> String.split("\n")
    line_len = lines |> List.first() |> String.length()
    input = lines |> Enum.join("")

    Regex.scan(~r/\d+/, input, return: :index)
    |> Enum.map(fn [{idx, len}] ->
      number = String.slice(input, idx..(idx + len - 1)) |> String.to_integer()
      to_check = create_checklist(idx, line_len, len)

      gears =
        to_check
        |> Enum.reduce(
          [],
          fn idx, acc ->
            char = String.at(input, idx)

            cond do
              !char ->
                acc

              Regex.match?(~r/[*]/, char) ->
                acc ++ [idx]

              true ->
                acc
            end
          end
        )

      {gears, number}
    end)
    |> Enum.group_by(&(&1 |> elem(0)))
    |> Enum.filter(fn
      {[], _} -> false
      {_, gears} when length(gears) > 1 -> true
      _ -> false
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.map(&(Enum.map(&1, fn item -> elem(item, 1) end) |> Enum.product()))
    |> Enum.sum()
  end

  def pt1(input) do
    lines = input |> String.split("\n")
    line_len = lines |> List.first() |> String.length()
    input = lines |> Enum.join("")

    Regex.scan(~r/\d+/, input, return: :index)
    |> Enum.map(fn [{idx, len}] ->
      number = String.slice(input, idx..(idx + len - 1)) |> String.to_integer()
      to_check = create_checklist(idx, line_len, len)

      part_number? =
        Enum.any?(
          to_check,
          fn idx ->
            char = String.at(input, idx)

            case char do
              nil -> false
              _ -> Regex.match?(~r/([^a-zA-Z0-9.])/, char)
            end
          end
        )

      if part_number?, do: number, else: 0
    end)
    |> Enum.sum()
  end
end
