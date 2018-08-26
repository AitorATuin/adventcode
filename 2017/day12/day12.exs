defmodule Day12 do
  def count(_, [],  n, _), do: n
  def count(tree, [x | xs], n, added) do
    case Map.get(added, x) do
      nil ->
        childs = Map.get(tree, x)
        added = Map.update(added, x, true, &(&1))
        count(tree, xs ++ childs, n + 1, added)
      _ -> 
        count(tree, xs, n, added)
    end
  end

  def solve() do
    parse() |> Day12.count(["0"], 0, %{})
  end

  def parse(input_stream) do
    input_stream |> Enum.reduce(%{}, fn line, dict ->
      [parent, childs] = line |> String.trim |> String.split(" <-> ")
      Map.update(dict, parent, childs |> String.split(",") |> Enum.map(&String.trim/1), &(&1))
    end)
  end
end

IO.stream(:stdio, :line) |> Day12.solve() |> IO.puts()
