#!/usr/bin/env ruby
# frozen_string_literal: true

beams = Set.new
splits = 0

ARGF.each_line do |line|
  new_beams = Set.new
  beams.each do |i|
    case line[i]
    when "."
      new_beams << i
    when "^"
      new_beams << (i - 1) if i > 0 and line[i - 1] == "."
      new_beams << (i + 1) if line[i + 1] == "."
      splits += 1
    end
  end
  s = line.index("S")
  new_beams << s unless s.nil?
  beams = new_beams
end

puts splits
