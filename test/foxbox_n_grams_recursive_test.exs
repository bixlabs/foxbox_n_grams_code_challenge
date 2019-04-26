defmodule FoxboxNGramsRecursiveTest do
  use ExUnit.Case

  alias FoxboxNGrams.Recursive, as: FoxboxNGrams

  test "generate n-grams for base example" do
    assert FoxboxNGrams.ngrams_permutation("Show me the code.") == [
      "Show",
      "Show me",
      "Show me the",
      "Show me the code",
      "me",
      "me the",
      "me the code",
      "the",
      "the code",
      "code"
    ]
  end

  test "generate n-grams for one word" do
    assert FoxboxNGrams.ngrams_permutation("Code") == ["Code"]
  end

  test "generate n-grams for empty text" do
    assert FoxboxNGrams.ngrams_permutation("") == []
  end

  test "generate n-grams for punctuations" do
    assert FoxboxNGrams.ngrams_permutation(",.!?") == []
  end

  test "generate n-grams with invalid argument" do
    assert_raise(ArgumentError, "the argument should be a string text", fn -> FoxboxNGrams.ngrams_permutation(5) end)
  end
end
