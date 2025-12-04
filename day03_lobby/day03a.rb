#!/usr/bin/env ruby
# frozen_string_literal: true

def process(filename)
  total_joltage = 0

  IO.foreach(filename) do |line|
    line = line.strip
    digits = line.chars.map { |c| Integer(c) }
    joltage = max_pair(digits)
    total_joltage += joltage
  end

  puts total_joltage
end

def max_pair(digits)
  max_left = 0
  max_value = 0
  digits[0..-2].each_with_index do |d1, i|
    next if d1 < max_left
    if d1 > max_left
      max_left = d1
    end
    digits[i + 1..-1].each do |d2|
      value = d1 * 10 + d2
      if value > max_value
        max_value = value
      end
    end
  end
  max_value
end

if __FILE__ == $0
  filename = ARGV.length > 0 ? ARGV[0] : File.join(File.dirname(__FILE__), "test.txt")
  process(filename)
end
