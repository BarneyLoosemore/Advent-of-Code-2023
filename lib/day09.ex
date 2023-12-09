defmodule Day09 do
  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line |> String.split() |> Enum.map(&String.to_integer/1)
    end)
  end

  def find_differences(_, sequences \\ [])

  def find_differences(sequence, sequences) do
    sequence_chunks = sequence |> Enum.chunk_every(2, 1, :discard)

    new_sequence =
      for [first, second] <- sequence_chunks do
        second - first
      end

    if Enum.all?(new_sequence, &(&1 === 0)),
      do: sequences,
      else: find_differences(new_sequence, sequences ++ [new_sequence])
  end

  def find_next_value(history) do
    sequences = history |> find_differences()
    (Enum.map(sequences, &List.last/1) |> Enum.sum()) + List.last(history)
  end

  def find_prev_value(history) do
    [last | sequences] =
      history |> find_differences() |> Enum.map(&List.first/1) |> Enum.reverse()

    diff =
      for curr <- sequences, reduce: last do
        prev ->
          curr - prev
      end

    List.first(history) - diff
  end

  def pt1(input) do
    input |> parse_input |> Enum.map(&find_next_value/1) |> Enum.sum()
  end

  def pt2(input) do
    input |> parse_input() |> Enum.map(&find_prev_value/1) |> Enum.sum()
  end
end
