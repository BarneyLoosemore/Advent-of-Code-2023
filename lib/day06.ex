defmodule Day06 do
  def ways_to_beat_record(time, record, ms \\ 1, ways \\ 0)
  def ways_to_beat_record(time, _, ms, ways) when time === ms, do: ways

  def ways_to_beat_record(time, record, ms, ways) when (time - ms) * ms > record,
    do: ways_to_beat_record(time, record, ms + 1, ways + 1)

  def ways_to_beat_record(time, record, ms, ways),
    do: ways_to_beat_record(time, record, ms + 1, ways)

  defp parse_input_pt1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&(String.split(&1, ":") |> List.last()))
    |> Enum.map(
      &(String.split(&1, " ", trim: true)
        |> Enum.map(fn s -> String.to_integer(s) end))
    )
  end

  defp parse_input_pt2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(
      &(String.split(&1, ":")
        |> List.last()
        |> String.replace(" ", "")
        |> String.to_integer())
    )
  end

  def pt1(input) do
    [times, records] = parse_input_pt1(input)

    for {time, idx} <- times |> Enum.with_index() do
      ways_to_beat_record(time, Enum.at(records, idx))
    end
    |> Enum.product()
  end

  def pt2(input) do
    [time, record] = parse_input_pt2(input)
    ways_to_beat_record(time, record)
  end
end
