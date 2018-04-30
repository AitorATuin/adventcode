local function is_valid_passphrase(line)
  local gen = line:gmatch("%w+")
  local words = {}
  local function _is_valid_passphrase(gen)
    local word = gen()
    if not word then return true end
    if words[word] then return false end
    words[word] = true
    return _is_valid_passphrase(gen)
  end
  return _is_valid_passphrase(gen)
end

local function main(...)
  local good_passphrases = 0
  for line in io.lines() do
    if is_valid_passphrase(line) then
      good_passphrases = good_passphrases + 1
    end
  end
  print(good_passphrases)
end

main()
