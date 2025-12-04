#!/usr/bin/env ruby
# frozen_string_literal: true

def process(filename)
  map = []

  max_x = -1
  max_y = -1

  IO.foreach(filename) do |line|
    line = line.strip
    max_x = line.length - 1 if max_x == -1
    map.push(line)
    max_y += 1
  end

  movable_rolls = 0

  for y in 0..max_y
    for x in 0..max_x
      next if map[y][x] == '.'
      adjacent_rolls = 0
      for nx in (x - 1)..(x + 1)
        next if nx < 0 or nx > max_x
        for ny in (y - 1)..(y + 1)
          next if ny < 0 or ny > max_y
          next if nx == x and ny == y
          if map[ny][nx] != '.'
            adjacent_rolls += 1
          end
        end
      end
      if adjacent_rolls < 4
        movable_rolls += 1
      end
    end
  end

  puts movable_rolls
end

if __FILE__ == $0
  filename = ARGV.length > 0 ? ARGV[0] : File.join(File.dirname(__FILE__), "test.txt")
  process(filename)
end
