#!/usr/bin/env ruby
# frozen_string_literal: true
def process(file)
  solutions = file.read.split("\n").each_with_index.map { |line, i| Machine.new(i + 1, line).min_steps }
  puts solutions.inject(:+)
end

class Machine
  def initialize(line_no, line)
    @line_no = line_no
    parts = line.split(" ")

    @desired_state = 0
    bit = 1
    parts[0].chars[1..-2].each do |c|
      @desired_state |= bit if c == "#"
      bit <<= 1
    end

    @buttons = parts[1..-2].map do |button_spec|
      b = 0
      button_spec[1..-2].split(",") do |s|
        b |= 1 << Integer(s)
      end
      b
    end
  end

  def min_steps
    worst = @buttons.size + 1
    steps = min_steps_rec(worst, 0, 0, @desired_state, @buttons)
    fail "no solution in line #{@line_no}" if steps >= worst
    steps
  end

  private

  def min_steps_rec(best, steps_so_far, state, desired_state, buttons)
    return steps_so_far if state == desired_state
    return best if buttons.empty?
    return best if steps_so_far >= best
    first_button_bits = buttons.first
    steps_not_pressed = min_steps_rec(best, steps_so_far, state, desired_state, buttons[1..])
    return steps_not_pressed if steps_not_pressed <= (steps_so_far + 1) # cut-off, can't get better
    min_steps_rec([best, steps_not_pressed].min, steps_so_far + 1, state ^ first_button_bits, desired_state, buttons[1..])
  end
end

process(ARGF)
