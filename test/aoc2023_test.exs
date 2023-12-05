defmodule Aoc2023Test do
  use ExUnit.Case

  test "Day 1" do
    input = Input.read!("1", :sample)
    input_pt2 = Input.read!("1", :sample_pt2)

    assert Day01.pt1(input) === 142
    assert Day01.pt2(input_pt2) === 281
  end
end
