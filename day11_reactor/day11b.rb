#!/usr/bin/env ruby
# frozen_string_literal: true
def process(file)
  edges_by_node = file.read.split("\n").map { it.split(": ") }.map { |(from_nodes, to_nodes)| [from_nodes, to_nodes.split(" ")] }.to_h
  edges_by_node.default = []
  different_paths = count_paths(edges_by_node, "svr", "out", {}, [])[:with_both]
  puts different_paths
end

def count_paths(edges_by_node, from, to, cache, path_so_far)
  if path_so_far.include?(from) # circle detection
    return { :without => 0, :with_fft => 0, :with_dac => 0, :with_both => 0 }
  end

  if cache.include?([from, to])
    return cache[[from, to]]
  end

  if from == to
    is_dac = from == "dac"
    is_fft = from == "fft"
    return {
      :without => !is_dac && !is_fft ? 1 : 0,
      :with_dac => is_dac ? 1 : 0,
      :with_fft => is_fft ? 1 : 0,
      :with_both => 0
    }
  end

  new_path = path_so_far + [from]
  r = { :without => 0, :with_fft => 0, :with_dac => 0, :with_both => 0 }
  edges_by_node[from].each do |next_node|
    r = r.merge(count_paths(edges_by_node, next_node, to, cache, new_path)) { |k, a, b| a + b }
  end

  case from
  when "dac"
    r[:with_both] = r[:with_fft] + r[:with_dac] + r[:with_both]
    r[:with_dac] = r[:without]
    r[:with_fft] = 0
    r[:without] = 0
  when "fft"
    r[:with_both] = r[:with_fft] + r[:with_dac] + r[:with_both]
    r[:with_dac] = 0
    r[:with_fft] = r[:without]
    r[:without] = 0
  end

  cache[[from, to]] = r

  r
end

process(ARGF)
