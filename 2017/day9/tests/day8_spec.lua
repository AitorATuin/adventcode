require "day9"

describe('Get groups score', function ()
  it('score #sample1', function ()
    local input = "{}"
    assert.is_equal(score(input), 1)
  end)
  it('score #sample2', function ()
    local input = "{{{}}}"
    assert.is_equal(score(input), 6)
  end)
  it('score #sample3', function ()
    local input = "{{},{}}"
    assert.is_equal(score(input), 5)
  end)
  it('score #sample4', function ()
    local input = "{{{},{},{{}}}}"
    assert.is_equal(score(input), 16)
  end)
  it('score #sample5', function ()
    local input = "{<a>,<a>,<a>,<a>}"
    assert.is_equal(score(input), 1)
  end)
  it('score #sample6', function ()
    local input = "{{<ab>},{<ab>},{<ab>},{<ab>}}"
    assert.is_equal(score(input), 9)
  end)
  it('score #sample7', function ()
    local input = "{{<!!>},{<!!>},{<!!>},{<!!>}}"
    assert.is_equal(score(input), 9)
  end)
  it('score #sample8', function ()
    local input = "{{<a!>},{<a!>},{<a!>},{<ab>}}"
    assert.is_equal(score(input), 3)
  end)
end)
