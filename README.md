# Advent of Code 2025 in Ruby

In my work as a freelancer, I have something like an on-off relationship with Ruby on Rails.
So I thought it might be a good idea to refresh the Ruby basics
by doing the AoC in Ruby.

## Usage

There is a directory for each day, containing a Ruby
program for each part, e.g. `day01a.rb` and `day01b.rb`.

All Ruby programs are executable scripts that take
the input file as their first command line parameter.
A program will simply print out the calculated result at the end.

They can be used like in this example:

```shell
% ./day01b.rb input.txt
6122
```

Calling the script without parameter will use `test.txt` as the input.

## Day 01 - Secret Entrance

Regular expressions are part of the language, which is nice.
But of course at first I forgot putting a $ sign at the end so the
match is exhaustive causing incomplete parsing without an error :D
In part two I first tried to calculate the number of
"zero crossings" by a formula, but looking at all the
edge cases I went for the stupid approach.

## Day 02 - Gift Shop

Reacquainted myself with Ruby's slicing syntax `[start, length]` vs. `[from..to]` (range) :-D

## Day 03 - Lobby

The solution is simple, but I had a few false starts.

## Day 04 - Printing Department

I haven't yet rediscovered the elegance of Ruby. But I have
understood that the Perl-ish `$ARGV` is now `ARGV` :-D

## Day 05 - Cafeteria

I had started building my own `Range` class until it dawned on me that I really
should use Ruby's existing class. Of course, at first, I forgot to merge with
possibly adjacent classes in the list.
Also, having a builtin `bsearch` method for binary search in `Array` was helpful.

## Day 06 - Trash Compactor

Nothing to see here. Ruby is built for text processing.
