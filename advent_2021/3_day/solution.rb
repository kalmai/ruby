require 'pry'

def binary_diagnostic(file)
  f = File.new(file, 'r')
  lines = `wc -l #{file}`.strip.split(' ')[0].to_i
  split_bits = {
    0 => 0,
    1 => 0,
    2 => 0,
    3 => 0,
    4 => 0,
    5 => 0,
    6 => 0,
    7 => 0,
    8 => 0,
    9 => 0,
    10 => 0,
    11 => 0
  }
  gamma_rate = ''
  epsilon_rate = ''

  f.each_line do |line|
    split_bit = line.strip.split('')
    split_bit.each.with_index do |bit, i|
      split_bits[i] += bit.to_i
    end
  end

  split_bits.each do |_, v|
    one_majority = (lines - v) < (lines / 2)
    gamma_rate << (one_majority ? '1' : '0')
  end

  gamma_rate.split('').each do |bit|
    epsilon_rate << (bit.eql?('1') ? '0' : '1')
  end

  gamma_rate = gamma_rate.to_i(2)
  epsilon_rate = epsilon_rate.to_i(2)

  gamma_rate * epsilon_rate
  # 9053058 is too high
end

puts binary_diagnostic('input.txt')
