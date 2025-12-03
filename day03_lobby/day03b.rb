#!/usr/bin/env ruby
# frozen_string_literal: true

def max_number(digits, length)
  fail ArgumentError if digits.length < length

  n = 0
  offset = 0

  while length > 0
    highest = digits[offset..-length].max
    n = n * 10 + highest
    offset += digits[offset..-length].index(highest) + 1
    length -= 1
  end

  n
end

total_joltage = 0

IO.foreach(ARGV[0]) do |line|
  line = line.strip
  digits = line.chars.map {|c| Integer(c)}
  joltage = max_number(digits, 12)
  total_joltage += joltage
end

puts total_joltage