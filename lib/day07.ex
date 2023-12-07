defmodule Day07 do
  @cards ~w"2 3 4 5 6 7 8 9 T J Q K A" |> Enum.with_index() |> Map.new()
  @hands [[1, 1, 1, 1, 1], [2, 1, 1, 1], [2, 2, 1], [3, 1, 1], [3, 2], [4, 1], [5]]
         |> Enum.with_index()
         |> Map.new()

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1))
    |> Enum.map(fn [hand, bid] ->
      [String.split(hand, "", trim: true), String.to_integer(bid)]
    end)
  end

  def get_strength(hand) do
    type =
      hand
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.sort(:desc)

    @hands[type]
  end

  def get_strength_pt2(hand) do
    freqs = hand |> Enum.frequencies()

    case freqs do
      %{"J" => 5} = _ ->
        6

      %{"J" => jokers} = freqs ->
        [max | rem_hand] = Map.delete(freqs, "J") |> Map.values() |> Enum.sort(:desc)
        type = [max + jokers | rem_hand]
        @hands[type]

      _ ->
        type = Map.values(freqs) |> Enum.sort(:desc)
        @hands[type]
    end
  end

  def compare_card_strengths(_, _, card_values \\ @cards)

  def compare_card_strengths([card_a | hand_a], [card_b | hand_b], card_values)
      when card_a === card_b do
    compare_card_strengths(hand_a, hand_b, card_values)
  end

  def compare_card_strengths([card_a | _], [card_b | _], card_values) do
    card_values[card_a] > card_values[card_b]
  end

  def sort_hands(hands) do
    Enum.sort(hands, fn [hand_a, _], [hand_b, _] ->
      strength_a = get_strength(hand_a)
      strength_b = get_strength(hand_b)

      cond do
        strength_a > strength_b -> true
        strength_a === strength_b -> compare_card_strengths(hand_a, hand_b)
        true -> false
      end
    end)
  end

  def sort_hands_pt2(hands) do
    card_values = %{@cards | "J" => -1}

    Enum.sort(hands, fn [hand_a, _], [hand_b, _] ->
      strength_a = get_strength_pt2(hand_a)
      strength_b = get_strength_pt2(hand_b)

      cond do
        strength_a > strength_b -> true
        strength_a === strength_b -> compare_card_strengths(hand_a, hand_b, card_values)
        true -> false
      end
    end)
  end

  def sum_winnings(sorted_hands) do
    sorted_hands
    |> Enum.map(&List.last/1)
    |> Enum.reverse()
    |> Enum.with_index(1)
    |> Enum.reduce(
      0,
      fn {bid, rank_multiplier}, total_winnings ->
        total_winnings + bid * rank_multiplier
      end
    )
  end

  def pt1(input) do
    input
    |> parse_input
    |> sort_hands
    |> sum_winnings
  end

  def pt2(input) do
    input
    |> parse_input
    |> sort_hands_pt2
    |> sum_winnings
  end
end
