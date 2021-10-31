require 'pry'

module PassPortCounter
  def return_valid_passport_count(file)
    input_file = File.open(file, 'r')
    passport_str = ""
    passport_count = 0

    input_file.each_line do |line|
      unless line.eql?("\n")
        passport_str << " " << line.strip
      else
        passport_hsh = passport_str.split(" ").each.with_object({}) do |pair, hsh|
          split_pair = pair.split(":")
          hsh[split_pair.first.to_sym] = split_pair.last
        end

        if passport_hsh.keys.size >= 7 && is_valid_north_pole_passport?(passport_hsh)
          passport_count += 1
        end

        passport_str = ""
      end
    end

    return passport_count
    
  end

  def is_valid_north_pole_passport?(hsh)
    if hsh.values.none? { |v| v.nil? } && hsh.keys.each { |k| [:ecl, :pid, :eyr, :hcl, :byr, :iyr, :hgt].include?(k) } 
      ecl = ecl?(hsh[:ecl])
      pid = pid?(hsh[:pid])
      eyr = eyr?(hsh[:eyr])
      hcl = hcl?(hsh[:hcl])
      byr = byr?(hsh[:byr])
      iyr = iyr?(hsh[:iyr])
      hgt = hgt?(hsh[:hgt])

      return ecl && pid && eyr && hcl && byr && iyr && hgt
    end
    return false
  end

  def ecl?(ecl)
    ecl && %w(amb blu brn gry grn hzl oth).include?(ecl)
  end

  def pid?(pid)
    pid && pid.length == 9 && pid.to_i > 0
  end

  def eyr?(eyr)
    eyr && eyr.length == 4 && eyr.to_i.between?(2020, 2030)
  end

  def hcl?(hcl)
    hcl && hcl[0].eql?("#") && hcl.length == 7 && hcl[1...].split("").all? { |c| /[0-9a-f]/.match?(c) }
  end

  def byr?(byr)
    byr && byr.length == 4 && byr.to_i.between?(1920, 2002)
  end

  def iyr?(iyr)
    iyr && iyr.length == 4 && iyr.to_i.between?(2010, 2020)
  end

  def hgt?(hgt)
    if hgt
      units = hgt[-2..]
      num = hgt[0..hgt.size - 3]
      return true if units.eql?("cm") && num.to_i.between?(150, 193)
      return true if units.eql?("in") && num.to_i.between?(59, 76)
    end
    return false
  end

  def is_between_values?(low, high, value)
    value.to_i.between?(low, high)
  end

end

include PassPortCounter

puts "enter input"
input = gets.strip

puts return_valid_passport_count(input)
