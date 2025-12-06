#!/usr/bin/env ruby
# frozen_string_literal: true

def process(filename)
  rows = []
  operators = []

  IO.foreach(filename) do |line|
    line = line.strip
    if line.start_with?(/^[+*]/)
      operators = line.split(/\s+/)
      break
    end
    rows << line.split(/\s+/).map { |s| Integer(s) }
  end

  sum = 0
  operators.each_with_index do |operator, i|
    if operator == '+'
      col_sum = 0
      rows.each do |row|
        col_sum += row[i]
      end
      sum += col_sum
    elsif operator == '*'
      col_product = 1
      rows.each do |row|
        col_product *= row[i]
      end
      sum += col_product
    else
      fail "invalid operator: #{operator}"
    end
  end

  puts sum
end

if __FILE__ == $0
  filename = ARGV.length > 0 ? ARGV[0] : File.join(File.dirname(__FILE__), "test.txt")
  process(filename)
end
