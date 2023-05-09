module CountryLookup

  class Lookup
    def initialize
      @country_codes = Array.new
      @ip_ranges = Array.new
      @country_table = Array.new
      initialize_from_file
    end

    def lookup_ip_string(ip_string)
      if ip_string.nil? || ip_string.empty?
        return nil
      end
      components = ip_string.split('.')
      if components.length < 4
        return nil
      end

      ip_number = components[0].to_i * 16777216 +
        components[1].to_i * 65536 +
        components[2].to_i * 256 +
        components[3].to_i

      self.lookup_ip_number(ip_number)
    end

    def lookup_ip_number(ip_number)
      index = binary_search(ip_number)
      cc = @country_codes[index]
      if cc == '--'
        return nil
      end
      cc
    end

    private

    def binary_search(value)
      min = 0
      max = @ip_ranges.length - 1
      while min < max do
        mid = (min + max) >> 1
        if @ip_ranges[mid] <= value
          min = mid + 1
        else
          max = mid
        end
      end
      min
    end


    # The binary is packed as follows:
    # c1.c2.c3.....**: Country code look up table, terminated by **
    #
    # n1.c: if n is < 240, c is country code index
    # 242.n2.n3.c: if n >= 240 but < 65536. n2 being lower order byte
    # 243.n2.n3.n4.c: if n >= 65536. n2 being lower order byte
    def initialize_from_file
      unless @country_codes.length == 0
        return
      end

      File.open(File.dirname(__FILE__) + '/ip_supalite.table') do |file|
        until file.eof?
          c1 = file.read(1)
          c2 = file.read(1)

          @country_table.push(c1 + c2)
          if (c1 == '*')
            break
          end
        end
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

          @ip_ranges.push(last_end_range)
          @country_codes.push(@country_table[cc])
        end
      end
    end
  end

  def self.initialize
    if !@initialize_bg_thread.nil?
      Thread.kill(@initialize_bg_thread)
    end
    @lookup = Lookup.new
    return nil
  end

  def self.initializeAsync
    if !@initialize_bg_thread.nil? && @initialize_bg_thread.alive?
      @initialize_bg_thread.kill.join
    end
    @initialize_bg_thread = Thread.new { @lookup = Lookup.new }
    return @initialize_bg_thread
  end

  def self.is_ready_for_lookup
    !@lookup.nil?
  end

  def self.lookup_ip_string(ip_string)
    if @lookup.nil?
      @lookup = Lookup.new
    end
    @lookup.lookup_ip_string(ip_string)
  end

  def self.lookup_ip_number(ip_number)
    if @lookup.nil?
      @lookup = Lookup.new
    end
    @lookup.lookup_ip_number(ip_number)
  end

end