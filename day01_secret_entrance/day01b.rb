#!/usr/bin/env ruby
# frozen_string_literal: true

dial = 50
zero_count = 0

IO.foreach(ARGV[0]) do |line|
  fail "invalid input #{line}" if /^([LR])(\d+)$/.match(line).nil?

  distance = Integer($2)
  sign = $1 == 'R' ? 1 : -1
  distance.times do
   dial = (dial + sign) % 100
   zero_count += 1 if dial == 0
  end
end

puts zero_count
