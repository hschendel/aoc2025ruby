#!/usr/bin/env ruby
# frozen_string_literal: true

def process(file)
  points = file.read.split("\n").map { it.split(",").map(&:to_i) }
  pairs = all_pairs_with_dist_sorted(points)
  connect_pairs = pairs[0, points.length == 20 ? 10 : 1000]
  point_to_circuit = {}
  point_to_circuit.default = -1
  next_circuit_id = 1

  connect_pairs.each do |pair|
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
  end

  circuit_sizes = point_to_circuit
                    .group_by { it[1] }
                    .values.map { it.map { it.first } }
                    .map { it.length }
                    .sort.reverse
  top3_product = circuit_sizes[0..2].inject(:*)

  puts top3_product
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
