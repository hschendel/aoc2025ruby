#!/usr/bin/env ruby
# frozen_string_literal: true

def process(filename)
  invalid_sum = 0

  IO.foreach(filename) do |line|
    line = line.strip
    line.split(',').each do |range|
      values = range.split('-')
      fail "invalid range #{range}" unless values.length == 2
      # skip if range over only odd number of digits, cannot be invalid
      next if values[0].length == values[1].length && (values[0].length % 2 == 1)
      from = Integer(values[0])
      to = Integer(values[1])
      for i in from..to
        s = i.to_s
        next unless s.length % 2 == 0 # only values with even numbers can be invalid
        half_length = s.length / 2
        next unless s[0, half_length] == s[half_length, half_length]
        invalid_sum += i
      end
    end
  end

  puts invalid_sum
end

if __FILE__ == $0
  filename = ARGV.length > 0 ? ARGV[0] : File.join(File.dirname(__FILE__), "test.txt")
  process(filename)
end
