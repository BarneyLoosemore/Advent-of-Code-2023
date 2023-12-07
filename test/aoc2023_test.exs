defmodule Aoc2023Test do
  use ExUnit.Case

  test "Day 1" do
    input = Input.read!(1, :sample)
    input_pt2 = Input.read!(1, :sample_pt2)

    assert Day01.pt1(input) === 142
    assert Day01.pt2(input_pt2) === 281
  end

  test "Day 2" do
    input = Input.read!(2, :sample)

    assert Day02.pt1(input) === 8
    assert Day02.pt2(input) === 2286
  end

  test "Day 3" do
    input = Input.read!(3, :sample)

    assert Day03.pt1(input) === 4361
    assert Day03.pt2(input) === 467_835
  end

  test "Day 4" do
    input = Input.read!(4, :sample)

    assert Day04.pt1(input) === 13
    assert Day04.pt2(input) === 30
  end

  test "Day 5" do
    input = Input.read!(5, :sample)

    assert Day05.pass_through_map([[50, 98, 2], [52, 50, 48]], 79) === 81

    assert Day05.pass_through_mappers(
             [
               [[50, 98, 2], [52, 50, 48]],
               [[0, 15, 37], [37, 52, 2], [39, 0, 15]],
               [[49, 53, 8], [0, 11, 42], [42, 0, 7], [57, 7, 4]],
               [[88, 18, 7], [18, 25, 70]],
               [[45, 77, 23], [81, 45, 19], [68, 64, 13]],
               [[0, 69, 1], [1, 0, 69]],
               [[60, 56, 37], [56, 93, 4]]
             ],
             79
           ) === 82

    assert Day05.pt1(input) === 35
    assert Day05.pt2(input) === 46
  end

  test "Day 6" do
    input = Input.read!(6, :sample)

    assert Day06.ways_to_beat_record(7, 9) === 4
    assert Day06.pt1(input) === 288
    assert Day06.pt2(input) === 71503
  end

  test "Day 7" do
    input = Input.read!(7, :sample)

    assert Day07.pt1(input) === 6440
    assert Day07.pt2(input) === 5905

    assert Day07.get_strength(["A", "A", "A", "A", "A"]) === 6
    assert Day07.get_strength(["A", "A", "A", "A", "Q"]) === 5

    assert Day07.compare_card_strengths(
             ["A", "A", "A", "A", "A"],
             ["A", "A", "A", "A", "K"]
           ) === true

    assert Day07.compare_card_strengths(
             ["A", "A", "A", "A", "A"],
             ["A", "A", "A", "K", "K"]
           ) === true

    assert Day07.get_strength_pt2(["J", "K", "K", "K", "2"]) ===
             Day07.get_strength_pt2(["Q", "Q", "Q", "Q", "2"])

    assert Day07.get_strength_pt2(["A", "A", "A", "1", "2"]) === 3
  end
end
