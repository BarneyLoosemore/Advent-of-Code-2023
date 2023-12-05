defmodule Day04 do
  defp calc_score(0), do: 0
  defp calc_score(wins), do: 2 ** (wins - 1)

  defp find_wins([winning_nums, my_nums]) do
    my_nums
    |> Enum.reduce(
      0,
      fn num, wins ->
        cond do
          num in winning_nums -> wins + 1
          true -> wins
        end
      end
    )
  end

  defp format(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(
      &(&1
        |> String.split([": ", " | "])
        |> Enum.slice(1..-1)
        |> Enum.map(fn str ->
          str
          |> String.split(" ", trim: true)
          |> Enum.map(fn num -> num |> String.to_integer() end)
        end))
    )
  end

  defp find_accumulated_cards(games) do
    accumulated_cards = 1..Enum.count(games) |> Enum.map(fn _ -> 0 end) |> Enum.with_index()

    games
    |> Enum.with_index()
    |> Enum.reduce(
      accumulated_cards,
      fn {cards_won, win_idx}, cards ->
        curr_card_count = Enum.at(cards, win_idx) |> elem(0)
        card_range = if cards_won >= 1, do: (win_idx + 1)..(win_idx + cards_won), else: []

        cards
        |> Enum.map(fn
          {count, card_idx} ->
            cond do
              card_idx === win_idx -> {count + 1, win_idx}
              card_idx in card_range -> {count + curr_card_count + 1, card_idx}
              true -> {count, card_idx}
            end
        end)
      end
    )
  end

  def pt1(input) do
    input
    |> format
    |> Enum.map(&(&1 |> find_wins |> calc_score))
    |> Enum.sum()
  end

  def pt2(input) do
    input
    |> format
    |> Enum.map(&(&1 |> find_wins))
    |> find_accumulated_cards()
    |> Enum.map(&(&1 |> elem(0)))
    |> Enum.sum()
  end
end
