local function evaluate(instructions)
  local function _evaluate(i, n)
    local instruction = instructions[i]
    print(string.format("step: %d :: position: %d, instruction: %s", n, i, tostring(instruction)))
    if not instruction then return n end
    local next_i = i + instruction
    instructions[i] = instruction + 1
    return _evaluate(next_i, n+1)
  end
  return _evaluate(0, 0)
end

local function main(...)
  local instructions = {}
  i = 0
  for ins in io.lines() do
    instructions[i] = tonumber(ins)
    i = i + 1
  end
  print(#instructions)
  local steps = evaluate(instructions)
  print(string.format("steps after evaluation: %d", steps))
end

main()
