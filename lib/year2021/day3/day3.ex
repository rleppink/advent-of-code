defmodule Year2021.Day3 do

  def solve do
    input =
      Application.app_dir(:advent_of_code, "priv/input.2021.3")
      |> File.read!
      |> String.trim
      |> parse

    solve_1(input) |> IO.inspect(label: "Part 1")
    solve_2(input) |> IO.inspect(label: "Part 2")
  end

  def parse(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn x -> String.graphemes(x) |> Enum.map(&String.to_integer/1) end)
  end

  def solve_1(input) do
    input_count = div(Enum.count(input), 2)

    gamma =
      input
      |> Enum.reduce(
        [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
        fn curr, acc->
          acc_row(curr, acc)
        end)
      |> Enum.map(fn x -> if x >= input_count, do: 1, else: 0 end)

    epsilon = gamma |> Enum.map(fn x -> if x == 0, do: 1, else: 0 end)

    g = Enum.reduce(gamma, "", fn curr, acc -> acc <> Integer.to_string(curr) end) |> String.to_integer(2)
    e = Enum.reduce(epsilon, "", fn curr, acc -> acc <> Integer.to_string(curr) end) |> String.to_integer(2)

    g * e
  end

  defp acc_row(row, acc) do
    row
    |> Enum.with_index
    |> Enum.reduce(acc, fn {n, i}, c_acc ->
      ce = Enum.at(c_acc, i)
      List.replace_at(c_acc, i, (if n == 1, do: ce + 1, else: ce))
    end)
  end

  def list_to_string(bit_list) do
    bit_list
    |> Enum.reduce("", fn curr, acc -> acc <> Integer.to_string(curr) end)
    |> String.to_integer(2)
  end

  def solve_2_ex() do
    """
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
    """ |> parse |> solve_2
  end

  def solve_2(input) do
    mcb = solve_2(input, &most_common_bit/2, 0) |> list_to_string
    lcb = solve_2(input, &least_common_bit/2, 0) |> list_to_string

    mcb * lcb
  end
  def solve_2([last], _, _), do: last
  def solve_2(input, bit_fn, index) do
    bit = bit_fn.(input, index)
    solve_2(
      Enum.filter(input, fn x -> Enum.at(x, index) == bit end),
      bit_fn,
      index + 1)
  end

  defp most_common_bit(list, index) do
    {ones, n} =
      list
      |> Enum.reduce({0, 0}, fn curr, {ones, n} ->
        {(if Enum.at(curr, index) == 1, do: ones + 1, else: ones), n + 1}
      end)

    if ones >= Float.ceil(n / 2) |> trunc, do: 1, else: 0
  end

  defp least_common_bit(list, index) do
    if most_common_bit(list, index) == 1, do: 0, else: 1
  end

end
