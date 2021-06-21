module CountryLookup

  class Lookup
    def initialize
      initialize_from_file
    end

    def lookup_ip_string(ip_string)
      if ip_string.nil? || ip_string.empty?
        puts "empty"
        return nil
      end
      components = ip_string.split('.')
      if components.length < 4
        puts "less than 4"
        return nil
      end

      ip_number = components[0].to_i * 16777216 +
        components[1].to_i * 65536 +
        components[2].to_i * 256 +
        components[3].to_i
      puts ip_number

      self.lookup_ip_number(ip_number)
    end

    def lookup_ip_number(ip_number)
      index = self.binary_search(ip_number)
      puts index.to_s
      cc = @country_codes[index]
      if cc == '--'
        puts "--"
        return nil
      end
      puts "cc"
      cc
    end

    private

    def binary_search(value)
      min = 0
      max = @ip_ranges.length - 1
      while min < max do
        mid = (min + max) >> 1
        puts min.to_s + ' ' + max.to_s + ' ' + mid.to_s
        puts @ip_ranges[mid]
        if @ip_ranges[mid] <= value
          min = mid + 1
        else
          max = mid
        end
      end
      min
    end

    def initialize_from_file
      unless @country_codes.nil? || @country_codes.length == 0
        return
      end
      @country_codes = Array.new
      @ip_ranges = Array.new
      @country_table = Array.new

      File.open(File.dirname(__FILE__) + '/ip_supalite.table') do |file|
        until file.eof?
          c1 = file.read(1)
          c2 = file.read(1)

          @country_table.push(c1 + c2)
          if (c1 == '*')
            break
          end
        end
        printed = 0
        last_end_range = 0
        until file.eof?
          count = 0
          n1 = file.read(1).ord
          if n1 < 240
            count = n1
          elsif n1 == 242
            n2 = file.read(1).ord
            n3 = file.read(1).ord
            count = n2 | (n3 << 8)
          elsif n1 == 243
            n2 = file.read(1).ord
            n3 = file.read(1).ord
            n4 = file.read(1).ord
            count = n2 | (n3 << 8) | (n4 << 16)
          end
          last_end_range += count * 256
          cc = file.read(1).ord
          if printed < 10
            puts(last_end_range.to_s)
            printed = printed + 1
          end

          @ip_ranges.push(last_end_range)
          @country_codes.push(@country_table[cc])
        end
      end
    end
  end

  def self.initialize
    @lookup = Lookup.new()
    return nil
  end

  def self.lookup_ip_string(ip_string)
    if @lookup.nil?
      @lookup = Lookup.new()
    end
    @lookup.lookup_ip_string(ip_string)
  end

  def self.lookup_ip_number(ip_number)
    if @lookup.nil?
      @lookup = Lookup.new()
    end
    @lookup.lookup_ip_number(ip_number)
  end

end