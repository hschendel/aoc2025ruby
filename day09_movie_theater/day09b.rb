#!/usr/bin/env ruby
# frozen_string_literal: true

def process(file)
  points = file.read.split("\n").map { it.split(",").map(&:to_i) }
  map = Map.new(points)

  max_area = 0

  points[0..-1].each_with_index do |a, ai|
    points[ai + 1..].each do |b|
      area = ((a[0] - b[0]).abs + 1) * ((a[1] - b[1]).abs + 1)
      next if area <= max_area
      next unless map.rectangle_inside(a, b)
      max_area = area
    end
  end

  puts max_area
end

class Map
  def initialize(points)
    @points = points
    @edges = @points.each_with_index.map { |p, pi| [points[pi - 1], p] }
  end

  def rectangle_inside(a, b)
    xs = [a[0], b[0]]
    ys = [a[1], b[1]]
    # we only check the "inner" rectangle because the borders might overlap
    left_x = xs.min + 1
    right_x = xs.max - 1
    right_x += 1 if right_x < left_x
    top_y = ys.min + 1
    bottom_y = ys.max - 1
    bottom_y += 1 if bottom_y < top_y
    top_left = [left_x, top_y]
    top_right = [right_x, top_y]
    bottom_left = [left_x, bottom_y]
    bottom_right = [right_x, bottom_y]
    borders = [[top_left, top_right], [top_right, bottom_right], [bottom_right, bottom_left], [bottom_left, top_left]]

    # the rectangle is inside the shape <=> its borders cross no edge
    @edges.each do |edge|
      borders.each do |b1, b2|
        return false if edges_cross(b1, b2, edge[0], edge[1])
      end
    end

    true
  end

  private

  def edges_cross(a1, a2, b1, b2)
    return false if a1[0] == a2[0] && b1[0] == b2[0] || a1[1] == a2[1] && b1[1] == b2[1] # parallel
    a1, a2, b1, b2 = b1, b2, a1, a2 if b1[0] == b2[0] # horizontal edge first
    in_range(a1[1], a2[1], b1[1]) && in_range(b1[0], b2[0], a1[0])
  end

  def in_range(a, b, v)
    a, b = b, a if a > b
    a <= v && v <= b
  end
end

process(ARGF)
