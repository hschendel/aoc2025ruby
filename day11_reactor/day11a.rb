#!/usr/bin/env ruby
# frozen_string_literal: true
def process(file)
  edges_by_node = file.read.split("\n").map { it.split(": ") }.map { |(from_nodes, to_nodes)| [from_nodes, to_nodes.split(" ")] }.to_h
  edges_by_node.default = []
  different_paths = count_paths(edges_by_node, "you", "out", [], {})
  puts different_paths
end

def count_paths(edges_by_node, from, to, path_so_far, cache)
  return 0 if path_so_far.include?(from) # circle detection
  return 1 if from == to

  if cache.include?([from, to])
    return cache[[from, to]]
  end

  new_path = path_so_far + [from]
  r = 0
  edges_by_node[from].each do |next_node|
    r += count_paths(edges_by_node, next_node, to, new_path, cache)
  end

  cache[[from, to]] = r

  r
end

process(ARGF)
