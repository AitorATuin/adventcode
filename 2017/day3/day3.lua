-- Algorithm searchs first in axis x and after in axis y, then computes the steps
--
-- Uses the fact that the square spiral grows with this pattern:
--
-- Taking 1 as the center and start of the spiral and assuming a cartesian plane
-- with origin in 1 we have the following plane:
--
--               .
--               .
--               .
--              61  
--              34
--              13
--               4
--... 69 40 19 6 1 2 11 28 53 86 ... 
--               8
--              23
--              46
--              77
--               .
--               .
--               .
-- We can then split it in 4 lines accros the plane:
-- 0  1  2   3   4  ... index
-- ----------------
-- 1  2  11  28  53 ... x positive
-- 1  4  13  34  61 ... y positive
-- 1  6  19  40  69 ... x negative
-- 1  8  23  46  77 ... y negative
--
-- The difference between the numbers in the first sequence (x positive axis) is
-- computed like this: 8i - 7
-- For the second sequence (y positive) is: 8i - 6
-- For the second sequence (y positive) is: 8i - 5
-- For the second sequence (y positive) is: 8i - 4
--
-- Knowing that to compute the number of steps to move an item in position n we can do:
--
--    1. See their position in the x positive axis, knowing the closest item in that axis
--    and the index
--    2. See their position (column) in that index
--    3. Compute the number of steps with:
--          number_of_steps = i + n - y
--
--          where i is the index, n the number, and y the column computed in 2
--      

-- Finds n in the x axis
local function find_x(n)
  local function _find_x(i, x, n)
    if x == n then
      -- return current
      return x, i
    elseif x > n then
      -- return previous
      return x - (8*i - 7), i-1
    else
      return _find_x(i+1, x + 8*(i+1) - 7, n)
    end
  end
  return _find_x(0, 1, n)
end

-- find n in the y axis
local function find_y(x, i, n)
  local function _find_y(y, n, max_value)
    if y > max_value then
      error("y out of limits!!")
    end
    if n <= y then
      local prev_y = y - 2*i
      local bottom = n - prev_y
      local top = y - n
      -- We got it, compute which limit is closer
      if top <= bottom then
        return y
      else
        return prev_y
      end
    else
      return _find_y(y + 2*i, n, max_value)
    end
  end
  -- We know the max value expected for this item
  -- since there are only 4 axis y should be less than x + 8*i
  return _find_y(x, n, x + 8*i)
end

local function main(...)
  local args = {...}
  local n = tonumber(args[1])
  local x, i = find_x(n)
  local y = find_y(x, i, n)
  print(string.format("axis x: %d, axis y: %d, index: %d, value: %d", x, y, i, n))
  print(string.format("steps required: %d", i + n - y))
end

main(...)
