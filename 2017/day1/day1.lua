
local function captcha(sol, first_digit, prev_digit, iter)
  local next_digit = iter()
  if not next_digit then
    if first_digit == prev_digit then
      return sol
    else
      return sol+first_digit
    end
  end
  if prev_digit == next_digit then
    return captcha(sol+prev_digit, first_digit, next_digit, iter)
  else
    return captcha(sol, first_digit, next_digit, iter)
  end
end

local function main(...)
  local input = io.stdin:read("*all")

  local iter = input:gmatch(".")
  local first_digit = iter()
  print(captcha(0, first_digit, first_digit, iter))
end

main()

