#!/usr/bin/env ruby
# frozen_string_literal: true

dial = 50
zero_count = 0

IO.foreach(ARGV[0]) do |line|
  fail "invalid input #{line}" if /^([LR])(\d+)$/.match(line).nil?

  distance = Integer($2)

  if $1 == 'L'
    dial = (dial - distance) % 100
  else
    dial = (dial + distance) % 100
  end

  zero_count += 1 if dial == 0
end

puts zero_count
