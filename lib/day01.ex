defmodule Day01 do
  @num_map %{
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  defp get_calibration_val([]), do: "0"
  defp get_calibration_val([num]), do: "#{num}#{num}"
  defp get_calibration_val(nums), do: "#{List.first(nums)}#{List.last(nums)}"

  defp calc_line(line) do
    line
    |> String.graphemes()
    |> Enum.filter(&(Integer.parse(&1) |> is_tuple()))
    |> get_calibration_val
    |> String.to_integer()
  end

  defp map_num(num) do
    if num in Map.keys(@num_map), do: @num_map[num], else: num
  end

  defp match_regex(matcher, line) do
    Regex.compile!(matcher)
    |> Regex.scan(line, return: :index)
    |> Enum.map(fn
      [] -> 0
      [{idx, _}] -> idx
    end)
  end

  defp calc_line_pt2(line) do
    freqs =
      (Map.values(@num_map) ++ Map.keys(@num_map))
      |> Enum.map(fn matcher ->
        matches = match_regex(matcher, line)
        {matcher, matches}
      end)
      |> Enum.filter(fn
        {_, []} -> false
        _ -> true
      end)

    first =
      freqs
      |> Enum.min_by(fn {_, idxs} -> Enum.min(idxs) end)
      |> then(fn {first, _} -> map_num(first) end)

    last =
      freqs
      |> Enum.max_by(fn {_, idxs} -> Enum.max(idxs) end)
      |> then(fn {last, _} -> map_num(last) end)

    get_calibration_val([first, last])
    |> String.to_integer()
  end

  def pt1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&calc_line(&1))
    |> Enum.sum()
  end

  def pt2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&calc_line_pt2(&1))
    |> Enum.sum()
  end
end
