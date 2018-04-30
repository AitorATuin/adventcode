local registers = {}

--- access_register
-- register_name
local function access_register(r)
  if not registers[r] then
    registers[r] = 0
  end
  return registers[r]
end

local function set_register(r, v)
  registers[r] = v
end

local function instruction(op)
  local operators = {
    inc = function(r, v) return access_register(r) + v end,
    dec = function(r, v) return access_register(r) - v end,
  }
  return function(r ,v) 
    set_register(r, operators[op](r,v))
  end
end

local function conditional(op)
  local conditionals = {
    ["<"]  = function(r, v) return access_register(r) < v end,
    ["<="] = function(r, v) return access_register(r) <= v end,
    [">"]  = function(r, v) return access_register(r) > v end,
    [">="] = function(r, v) return access_register(r) >= v end,
    ["=="] = function(r, v) return access_register(r) == v end,
    ["!="] = function(r, v) return access_register(r) ~= v end,
  }
  return function(r, v)
    return conditionals[op](r, v) end
end

--- runner
--
local function execute(r1, o1, v1, r2, o2, v2)
  local inst = instruction(o1)
  local cond = conditional(o2)
  print(string.format("Executing %s %s %s if %s %s %s", r1, o1, v1, r2, o2, v2))
  if cond(r2, v2) then inst(r1, v1) end
end

--- line_parser
-- line
function line_parser(line)
  -- reg1 op1 value1 if reg2 op2 value2
  local parser = line:gmatch("(%w+) (%w+) (-?%d+) if (%w+) ([>=!<]+) (-?%d+)")  
  local r1, o1, v1, r2, o2, v2 = parser()
  return r1, o1, tonumber(v1), r2, o2, tonumber(v2)
end

--- main
-- ...
function main(...)
  for line in io.lines() do
    execute(line_parser(line)) 
  end
  -- Get largest register
  local max = 0
  for i, v in pairs(registers) do
    if v > max then max = v end
  end
  print(string.format("Largest value in registers is %d", max))
end

main()
