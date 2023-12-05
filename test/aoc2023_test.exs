defmodule Aoc2023Test do
  use ExUnit.Case

  test "Day 1" do
    input = Input.read!("1", :sample)
    input_pt2 = Input.read!("1", :sample_pt2)

    assert Day01.pt1(input) === 142
    assert Day01.pt2(input_pt2) === 281
  end

  test "Day 2" do
    input = Input.read!("2", :sample)

    assert Day02.pt1(input) === 8
    assert Day02.pt2(input) === 2286
  end

  test "Day 3" do
    input = Input.read!("3", :sample)

    assert Day03.pt1(input) === 4361
    assert Day03.pt2(input) === 467_835
  end
end
