#!/usr/bin/env ruby
# frozen_string_literal: true

def process(filename)
  numbers = {}
  numbers.default = 0
  total = 0

  IO.foreach(filename) do |line|
    if line.start_with?(/^[+*]/)
      operator = ''
      value = 0
      numbers.keys.sort.each do |i|
        if i < line.length && (line[i] == '*' or line[i] == '+')
          total += value
          operator = line[i]
          value = operator == '*' ? 1 : 0
        end
        if operator == '*'
          value *= numbers[i]
        else
          value += numbers[i]
        end
      end
      total += value
    else
      i = 0
      line.each_char do |c|
        if '0' <= c && c <= '9'
          numbers[i] = numbers[i] * 10 + Integer(c)
        end
        i += 1
      end
    end
  end

  puts total
end

if __FILE__ == $0
  filename = ARGV.length > 0 ? ARGV[0] : File.join(File.dirname(__FILE__), "test.txt")
  process(filename)
end
