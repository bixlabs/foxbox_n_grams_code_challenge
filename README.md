# FoxboxNGrams

This is a small programming problem to test your technical ability and coding style.

[Foxbox N-Grams Code Challenge](https://gist.github.com/robvolk/fc0508cb1892b0a58c4e)

## Instructions
Write a simple script to generate a set of [n-grams](http://en.wikipedia.org/wiki/N-gram) from a string of text.  N-grams are a contiguous sequence of n words from a string of text, and have many applications from full-text search indexes to machine learning.

You'll generate a set of every permutation of contiguous n-grams from a string of text, from 1-gram to n-grams where n is the number of words in the string

## How to run it?

```bash
$ iex -S mix
```

```elixir
iex(1)> FoxboxNGrams.Recursive.ngrams_permutation("Show me the code.")
```

## How to test it?

```bash
$ mix test
```

