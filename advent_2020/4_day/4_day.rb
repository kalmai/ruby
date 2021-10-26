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
    ecl = hsh.key?(:ecl)
    pid = hsh.key?(:pid)
    eyr = hsh.key?(:eyr)
    hcl = hsh.key?(:hcl)
    byr = hsh.key?(:byr)
    iyr = hsh.key?(:iyr)
    cid = hsh.key?(:cid)
    hgt = hsh.key?(:hgt)

    return ecl && pid && eyr && hcl && byr && iyr && hgt

  end

end

include PassPortCounter

puts "enter input"
input = gets.strip

puts return_valid_passport_count(input)
