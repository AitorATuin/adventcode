local n_banks = 4

-- Serializes a banks struct into a string.
-- Used to hash the banks
local function serialize_banks(banks)
  local str = ""
  for _, b in ipairs(banks) do
    str = string.format("%s %0.2d", str, b)
  end
  return str
end

-- Searchs the max value and max index for the block in blocks
local function search_max(blocks, max_v, max_i, i)
  if not blocks[i] then return max_v, max_i end -- no more blocks, return.
  if blocks[i] > max_v then 
    return search_max(blocks, blocks[i], i, i+1) 
  else
    return search_max(blocks, max_v, max_i, i+1)
  end
end

-- Runs a distribute cycle in the memory
local function run_cycle(banks, i, n)
  if i > n_banks then i = 1 end -- after last item, go to first again
  if n == 0 then return nil end -- end of cycle
  banks[i] = banks[i] + 1
  return run_cycle(banks, i+1, n-1)
end

local function distribute_memory(banks)
  -- upvalues
  local configurations = {}
  local _, max_bank = search_max(banks, 0, -1, 1)

  -- rec function
  local function _distribute_memory(n)
    local banks_str = serialize_banks(banks)
    if configurations[banks_str] then
      print(string.format("loop detected on input %s", banks_str))
      return n -- base case, loop detected
    else
      configurations[banks_str] = true
    end
    print(string.format("cycle: %s, candidate: %d", banks_str, max_bank))
    local bank_size = banks[max_bank]
    banks[max_bank] = 0
    max_bank = run_cycle(banks, max_bank+1, bank_size)
     _, max_bank = search_max(banks, 0, -1, 1)
    return _distribute_memory(n+1)
  end

  -- solve it!
  return _distribute_memory(0)
end

local function main()
  local banks = {}
  local max_value = 0
  local max_bank = 0
  local line = io.stdin:read("*all")
  for block in line:gmatch("%d+") do
    banks[#banks+1] = tonumber(block)
  end
  n_banks = #banks
  _, max_bank = search_max(banks, 0, -1, 1)
  print(string.format("steps before loop: %d", distribute_memory(banks)))
end

main()
