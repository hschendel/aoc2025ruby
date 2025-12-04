#!/usr/bin/env ruby
# frozen_string_literal: true

def process(filename)
  invalid_sum = 0

  IO.foreach(filename) do |line|
    line = line.strip
    line.split(',').each do |range|
      values = range.split('-')
      fail "invalid range #{range}" unless values.length == 2
      from = Integer(values[0])
      to = Integer(values[1])
      for i in from..to
        s = i.to_s
        half_length = s.length / 2
        invalid = false
        for seq_len in 1..half_length
          next unless s.length % seq_len == 0 # must cover whole id string
          seq = s[0, seq_len]
          valid = false
          (seq_len..s.length - 1).step(seq_len) do |offset|
            next if seq == s[offset, seq_len]
            valid = true
            break
          end
          invalid = !valid
          break if invalid
        end
        invalid_sum += i if invalid
      end
    end
  end

  puts invalid_sum
end

if __FILE__ == $0
  filename = ARGV.length > 0 ? ARGV[0] : File.join(File.dirname(__FILE__), "test.txt")
  process(filename)
end
