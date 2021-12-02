defmodule Year2021.Day2 do

  def solve do
    input =
      Application.app_dir(:advent_of_code, "priv/input.2021.2")
      |> File.read!
      |> String.trim
      |> parse

    solve_1(input) |> IO.inspect(label: "Part 1")
    solve_2(input) |> IO.inspect(label: "Part 2")
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn x -> String.split(x, " ") end)
    |> Enum.map(fn [direction, amount] -> [direction, String.to_integer(amount)] end)
  end

  def solve_1(input) do
    {horizontal, vertical} =
      Enum.reduce(
        input,
        {0, 0},
        fn [direction, amount], {hor, ver} ->
          case direction do
            "forward" -> {hor + amount, ver}
            "down" -> {hor, ver + amount}
            "up" -> {hor, ver - amount}
          end
        end)

    horizontal * vertical
  end

  def solve_2(input) do
    {horizontal, vertical, _} =
      Enum.reduce(
        input,
        {0, 0, 0},
        fn [direction, amount], {hor, ver, aim} ->
          case direction do
            "forward" -> {hor + amount, ver + amount * aim, aim}
            "down" -> {hor, ver, aim + amount}
            "up" -> {hor, ver, aim - amount}
          end
        end)

    horizontal * vertical
  end

end
