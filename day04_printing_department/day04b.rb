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

  total_removed_rolls = 0
  removed_rolls = 1
  while removed_rolls > 0
    removed_rolls = remove_rolls(map)
    total_removed_rolls += removed_rolls
  end

  puts total_removed_rolls
end

def remove_rolls(map)
  max_y = map.length - 1
  max_x = max_y >= 0 ? map[0].length - 1 : -1

  to_remove = []

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
        to_remove.push([y, x])
      end
    end
  end

  to_remove.each do |v|
    y = v[0]
    x = v[1]
    map[y][x] = '.'
  end

  to_remove.length
end

if __FILE__ == $0
  filename = ARGV.length > 0 ? ARGV[0] : File.join(File.dirname(__FILE__), "test.txt")
  process(filename)
end
