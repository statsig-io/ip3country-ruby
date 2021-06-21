require 'minitest'
require 'minitest/autorun'
require 'country_lookup'

class TestRandom < Minitest::Test

  def before_setup
    super
    CountryLookup.initialize
  end

  def test_random
    internal_lookup = CountryLookup.instance_eval { @lookup }
    ip_ranges = internal_lookup.instance_eval { @ip_ranges }
    cc = internal_lookup.instance_eval { @country_codes }

    i = 1
    while i < ip_ranges.length
      max = ip_ranges[i]
      min = ip_ranges[i - 1]
      expected = cc[i]
      assert(expected == lookup(min))
      assert(expected == lookup(max - 1))
      j = 0
      while j < 100
        randomIndex = min + rand(max - min)
        assert(expected == lookup(randomIndex))
        j += 1
      end
      i += 1
    end
  end

  def lookup(index)
    result = CountryLookup.lookup_ip_number(index)
    if result.nil?
      return '--'
    end
    return result
  end
end