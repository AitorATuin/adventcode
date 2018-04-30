local function compute_line(max, min, iter)
  local n = iter()
  if not n then
    return max, min
  end
  n = tonumber(n)
  if n > max then
    return compute_line(n, min, iter)
  elseif n < min then
    return compute_line(max, n, iter)
  else
    return compute_line(max, min, iter)
  end
end

local function compute_lines(sol, lines_iter)
  local next_line = lines_iter()
  if not next_line then
    return sol
  end
  local line_iter = next_line:gmatch("%d+")
  local first_number = tonumber(line_iter())
  local max, min = compute_line(first_number, first_number, line_iter)
  return compute_lines(sol + max - min, lines_iter)
end

local function main()
  local input = io.stdin:read("*all")
  local input_lines = input:gmatch("([^\n]+)\n?")
  print(compute_lines(0, input_lines))
end

main()
