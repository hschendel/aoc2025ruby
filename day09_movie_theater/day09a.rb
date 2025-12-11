#!/usr/bin/env ruby
# frozen_string_literal: true

max_area = 0

points = ARGF.read.split("\n").map { it.split(",").map(&:to_i) }
points[0..-1].each_with_index do |a, ai|
  points[ai + 1..].each do |b|
    area = ((a[0] - b[0]).abs + 1) * ((a[1] - b[1]).abs + 1)
    max_area = area if area > max_area
  end
end

puts max_area
