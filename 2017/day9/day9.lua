--- score
-- input
function score(input)
  local iter = input:gmatch(".")

  local function score(level, sum, iter, garbage_mode)
    local c = iter()
    if c == "{" and not garbage_mode then
      return score(level+1, sum, iter, false)
    elseif c  == "<" and not garbage_mode then
      return score(level, sum, iter, true)
    elseif c == "}" and not garbage_mode then
      return score(level-1, sum+level, iter, false)
    elseif c == ">" and garbage_mode then
      return score(level, sum, iter, false)
    elseif c == "!" then
      -- ignore next char
      iter()
      return score(level, sum, iter, garbage_mode)
    elseif not c then
      return sum
    else
      return score(level, sum, iter, garbage_mode)
    end
  end

  return score(0, 0, iter, false)
end


--- main
-- ...
function main(...)
  local input = io.stdin:read("*all")
  print(string.format("Total score for input: %d", score(input)))
end

main()
