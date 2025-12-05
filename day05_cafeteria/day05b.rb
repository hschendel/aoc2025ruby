#!/usr/bin/env ruby
# frozen_string_literal: true

def process(filename)
  ranges = Ranges.new

  IO.foreach(filename) do |line|
    line = line.strip
    if line.empty?
      break
    end
    fail "invalid ID range: #{line}" if /^(\d+)-(\d+)$/.match(line).nil?
    from = Integer($1)
    to = Integer($2)
    ranges.add(from..to)
  end

  puts ranges.count
end

class Ranges
  def initialize
    @ranges = []
  end

  def add(range)
    @ranges.each_with_index do |range_i, i|
      if ranges_overlap_or_adjacent?(range_i, range)
        @ranges[i] = merge_ranges(range_i, range)
        while (i + 1) < @ranges.length and ranges_overlap_or_adjacent?(@ranges[i], @ranges[i + 1])
          @ranges[i] = merge_ranges(@ranges[i], @ranges[i + 1])
          @ranges.delete_at(i + 1)
        end
        return
      elsif range.first < range_i.first
        @ranges.insert(i, range)
        return
      end
    end
    @ranges.push(range)
  end

  def contains?(number)
    found = @ranges.bsearch { |range| number > range.last ? 1 : number < range.first ? -1 : 0 }
    not found.nil?
  end

  def count
    total = 0
    @ranges.each do |range|
      total += range.count
    end
    total
  end
end

def ranges_overlap_or_adjacent?(a, b)
  if a.first < b.first
    (a.last + 1) >= b.first
  elsif b.first < a.first
    (b.last + 1) >= a.first
  else
    true
  end
end

def merge_ranges(a, b)
  [a.first, b.first].min..[a.last, b.last].max
end

if __FILE__ == $0
  filename = ARGV.length > 0 ? ARGV[0] : File.join(File.dirname(__FILE__), "test.txt")
  process(filename)
end
