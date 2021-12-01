defmodule Year2021.Day1 do

  def solve do
    input =
      Application.app_dir(:advent_of_code, "priv/input.2021.1")
      |> File.read!
      |> String.trim
      |> parse

    solve_1(input) |> IO.inspect(label: "Part 1")
    solve_2(input) |> IO.inspect(label: "Part 2")
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end

  def solve_1(input), do: solve_1(input, 0)
  def solve_1([_ | []], acc), do: acc
  def solve_1([one | [two | tail]], acc) do
    if two > one do
      solve_1([two | tail], acc + 1)
    else
      solve_1([two | tail], acc)
    end
  end

  def solve_2(input), do: solve_2(input, 0)
  def solve_2(input, acc) do
    if Enum.count(input) < 4 do
      acc
    else
      sumA = input |> Enum.take(3) |> Enum.sum
      sumB = input |> Enum.drop(1) |> Enum.take(3) |> Enum.sum

      if sumB > sumA do
        solve_2(Enum.drop(input, 1), acc + 1)
      else
        solve_2(Enum.drop(input, 1), acc)
      end
    end
  end

end
