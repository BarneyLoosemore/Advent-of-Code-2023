Benchee.run(%{
  "Day 1" => fn -> Day01.pt1(Input.read!(1)) end,
  "Day 2" => fn -> Day02.pt1(Input.read!(2)) end,
  "Day 3" => fn -> Day03.pt1(Input.read!(3)) end,
  "Day 4" => fn -> Day04.pt1(Input.read!(4)) end,
  "Day 5" => fn -> Day05.pt1(Input.read!(5)) end,
  "Day 6" => fn -> Day06.pt1(Input.read!(6)) end,
  "Day 7" => fn -> Day07.pt1(Input.read!(7)) end,
  "Day 8" => fn -> Day08.pt1(Input.read!(8)) end,
  "Day 9" => fn -> Day09.pt1(Input.read!(9)) end
})
