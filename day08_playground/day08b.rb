#!/usr/bin/env ruby
# frozen_string_literal: true

def process(file)
  points = file.read.split("\n").map { it.split(",").map(&:to_i) }
  pairs = all_pairs_with_dist_sorted(points)
  point_to_circuit = {}
  point_to_circuit.default = -1
  next_circuit_id = 1
  last_pair = nil

  pairs.each do |pair|
    c1 = point_to_circuit[pair.p1]
    c2 = point_to_circuit[pair.p2]
    if c1 == -1 and c2 == -1
      point_to_circuit[pair.p1] = next_circuit_id
      point_to_circuit[pair.p2] = next_circuit_id
      next_circuit_id += 1
    elsif c2 == -1
      point_to_circuit[pair.p2] = c1
    elsif c1 == -1
      point_to_circuit[pair.p1] = c2
    else
      # merge circuits
      point_to_circuit.transform_values! { it == c2 ? c1 : it }
    end

    if point_to_circuit.size == points.size and point_to_circuit.values.uniq.size == 1
      last_pair = pair
      break
    end
  end

  last_pair_x_product = last_pair.p1[0] * last_pair.p2[0]

  puts last_pair_x_product
end

def square_dist(p1, p2)
  d = 0
  (0..2).each do |i|
    d += (p1[i] - p2[i]) ** 2
  end
  d
end

def all_pairs_with_dist_sorted(points)
  pairs = []
  (0..points.length - 1).each do |i|
    p = points[i]
    pairs += points[i + 1, points.length].map { PointPairWithDist.new(p, it) }
  end
  pairs.sort! { |a, b| a.dist <=> b.dist }
  pairs
end

class PointPairWithDist
  def initialize(p1, p2)
    @p1, @p2 = p1, p2
    @dist = square_dist(@p1, @p2)
  end

  def p1
    @p1
  end

  def p2
    @p2
  end

  def dist
    @dist
  end
end

process(ARGF)
