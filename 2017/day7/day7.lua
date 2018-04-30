--- solve the problem
-- gen
function solve(gen)
  local referenced = {}
  local no_referenced = {}
  local no_referenced_count = 0
  --- recursive solution
  -- gen
  function _solve(gen)
    local first = true
    local line = gen()
    if not line then return end
    line:gsub("(%a+)", function (w)
      if first then
        if not referenced[w] then
          no_referenced[w] = true
          no_referenced_count = no_referenced_count + 1
        end
        first = false
      else
        referenced[w] = true
        if no_referenced[w] then
          no_referenced[w] = nil
          no_referenced_count = no_referenced_count - 1
        end
      end
     end)
    return _solve(gen)
  end

  _solve(gen)
  return no_referenced, no_referenced_count
end

--- main function
-- ...
function main(...)
  local generator = io.lines()
  local no_referenced, no_referenced_count = solve(generator)
  if no_referenced_count ~= 1 then
    error(string.format("There should be only 1 parent but we found %d", no_referenced_count))
  end
  print(string.format("Parent node: %s", next(no_referenced)))
  return nil
end

main()
