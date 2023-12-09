defmodule Aoc2023Test do
  use ExUnit.Case

  test "Day 1" do
    input = Input.read!(1, :test)
    input_pt2 = Input.read!(1, :test_pt2)

    assert Day01.pt1(input) === 142
    assert Day01.pt2(input_pt2) === 281
  end

  test "Day 2" do
    input = Input.read!(2, :test)

    assert Day02.pt1(input) === 8
    assert Day02.pt2(input) === 2286
  end

  test "Day 3" do
    input = Input.read!(3, :test)

    assert Day03.pt1(input) === 4361
    assert Day03.pt2(input) === 467_835
  end

  test "Day 4" do
    input = Input.read!(4, :test)

    assert Day04.pt1(input) === 13
    assert Day04.pt2(input) === 30
  end

  test "Day 5" do
    input = Input.read!(5, :test)

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
    input = Input.read!(6, :test)

    assert Day06.ways_to_beat_record(7, 9) === 4
    assert Day06.pt1(input) === 288
    assert Day06.pt2(input) === 71503
  end

  test "Day 7" do
    input = Input.read!(7, :test)

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

  test "Day 8" do
    input = Input.read!(8, :test)
    input_pt2 = Input.read!(8, :test_pt2)

    assert Day08.pt1(input) === 2

    assert Day08.find_zzz(
             [0, 0],
             [0, 0],
             "AAA",
             %{"AAA" => ["BBB", "CCC"], "BBB" => ["ZZZ", "FFF"]}
           ) === 2

    assert Day08.pt2(input_pt2) === 6
  end

  test "Day 9" do
    input = Input.read!(9, :test)

    assert Day09.parse_input(input) === [
             [0, 3, 6, 9, 12, 15],
             [1, 3, 6, 10, 15, 21],
             [10, 13, 16, 21, 30, 45]
           ]

    assert Day09.find_differences([0, 3, 6, 9, 12, 15]) === [[3, 3, 3, 3, 3]]
    assert Day09.find_differences([1, 3, 6, 10, 15, 21]) === [[2, 3, 4, 5, 6], [1, 1, 1, 1]]

    assert Day09.find_differences([10, 13, 16, 21, 30, 45]) === [
             [3, 3, 5, 9, 15],
             [0, 2, 4, 6],
             [2, 2, 2]
           ]

    assert Day09.find_next_value([0, 3, 6, 9, 12, 15]) === 18
    assert Day09.find_next_value([1, 3, 6, 10, 15, 21]) === 28
    assert Day09.find_next_value([10, 13, 16, 21, 30, 45]) === 68

    assert Day09.pt1(input) === 114

    assert Day09.find_prev_value([0, 3, 6, 9, 12, 15]) === -3
    assert Day09.find_prev_value([1, 3, 6, 10, 15, 21]) === 0
    assert Day09.find_prev_value([10, 13, 16, 21, 30, 45]) === 5
    assert Day09.pt2(input) === 2
  end
end
