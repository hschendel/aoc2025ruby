#!/usr/bin/env ruby
# frozen_string_literal: true

def process(filename)
  total_joltage = 0

  IO.foreach(filename) do |line|
    line = line.strip
    digits = line.chars.map { |c| Integer(c) }
    joltage = max_number(digits, 12)
    total_joltage += joltage
  end

  puts total_joltage
end

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

if __FILE__ == $0
  filename = ARGV.length > 0 ? ARGV[0] : File.join(File.dirname(__FILE__), "test.txt")
  process(filename)
end
