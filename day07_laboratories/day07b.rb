#!/usr/bin/env ruby
# frozen_string_literal: true

beams = {}

ARGF.each_line do |line|
  new_beams = {}
  new_beams.default = 0
  beams.each do |i, t|
    case line[i]
    when "."
      new_beams[i] += t
    when "^"
      new_beams[i - 1] += t if i > 0 and line[i - 1] == "."
      new_beams[i + 1] += t if line[i + 1] == "."
    end
  end
  s = line.index("S")
  new_beams[s] = 1 unless s.nil?
  beams = new_beams
end

puts beams.values.sum
