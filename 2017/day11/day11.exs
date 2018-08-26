defmodule Day11 do
  def move({x, y}, mov) do
    case mov do
      "n"  -> {x, y + 1}
      "s"  -> {x, y - 1}
      "ne" -> {x + 1, y}
      "sw" -> {x - 1, y}
      "se" -> {x + 1, y - 1}
      "nw" -> {x - 1, y + 1}
      _   -> {x, y}
    end
  end

  def move_to_home(pos) do
    case pos do
      {0, 0} -> :none
      {0, y} when y > 0 -> "s"
      {0, _} -> "n"
      {x, 0} when x > 0 -> "sw"
      {_, 0} -> "ne" 
      {x, y} when x > 0 and y > 0 -> "sw"
      {x, y} when x > 0 and y < 0 -> "nw"
      {x, y} when x < 0 and y < 0 -> "ne"
      {x, y} when x < 0 and y > 0 -> "se"
    end
  end

  def stream_movements(pos) do 
    Stream.iterate({0, pos}, fn
      {n, pos} -> {n + 1, move(pos, move_to_home(pos))}
    end) 
  end

  def final_position(movements), do: Enum.reduce(movements, {0, 0}, &(move(&2, &1)))
  def shortest_path_n({x, x}), do: abs(x)
  def shortest_path_n(pos, move_limits \\ 1000) do
    sol = stream_movements(pos)
      |> Stream.take(move_limits) 
      |> Enum.drop_while(fn {_, {x, y}} -> x != 0 or y != 0 end) 
      |> List.first
    case sol do
      {n, _} -> n
      nil    -> raise "Error, solution not found. Try to increase the limit"
    end
  end

  def solve(movements) do
    pos = final_position(movements)
    shortest_path_n(pos)
  end

  def main() do
    IO.read(:line) |> String.trim |> String.split(",") |> solve |> IO.puts
  end
end

Day11.main()
