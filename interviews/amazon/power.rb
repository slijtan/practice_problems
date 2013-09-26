def power_slow(base, expo)
    return 0 if base == 0

    total = 1
    expo.abs.times do
        total *= base
    end

    if expo < 0
        1 / total
    else
        total
    end
end

def power(base, expo)
  return 1 if expo == 0
  return 0 if base == 0

  total = power_positive(base, expo.abs)

  if expo < 0
      1.0 / total
    else
      total
    end
end

def power_positive(base, expo)
  @cache ||= {}
  @cache[base] ||= {}
  return @cache[base][expo] if @cache[base][expo]

  if expo == 1
    return base
  else
    result = power_positive(base, expo/2) * power_positive(base, expo - expo/2)
    @cache[base][expo] = result
    return result
  end
end


p power(5,100000)
