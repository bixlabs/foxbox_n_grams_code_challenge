defmodule FoxboxNGrams.Iterative do
  @moduledoc """
    This module provides an iterative solution to the Foxbox N-Grams Code Challenge
  """

  alias FoxboxNGrams.Tokenizer

  @doc """
    Tokenizes and generates a set of every permutation of contiguous n-grams from a string of text,
    from 1-gram to n-grams where n is the number of words in the text

    ## Example

      iex> FoxboxNGrams.Iterative.ngrams_permutation("Show me the code.")
      [
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
  """
  @spec ngrams_permutation(String.t) :: list(String.t) | no_return()
  def ngrams_permutation(text) when is_binary(text), do: main_ngrams_permutation(text)
  def ngrams_permutation(_), do: raise ArgumentError, message: "the argument should be a string text"

  _ = """
    The general solution consists in two steps:

    1. Generate new lists of tokens, each of them starting from a different token and always ending always at the original one:

      ["Show", "me", "the", code"]
      ["me", "the", code"]
      ["the", code"]
      ["code"]

    2. To each of these lists we apply n-gram:

      ["Show", "me", "the", code"] --ngram-> ["Show", "Show me", "Show me the", "Show me the code"]
      ["me", "the", code"] --ngram-> ["me", "me the", "me the code"]

    Finally each of the results are concatenated.
  """
  @spec main_ngrams_permutation(String.t) :: list(String.t)
  defp main_ngrams_permutation(text) do
    text
    |> Tokenizer.tokenize()
    |> do_ngrams_permutation()
  end

  _ = """
    This function is in charge of generating the different permutations.
    It is done applying the ngram to each list starting from each token

    For example for the tokens:

      ["Show", "me", "the", code"]

    This function applies ngrams(["Show", "me", "the", code"]),
    then ngrams(["me", "the", code"]),
    then ngrams(["the", code"]), and so on.

    Finally a list of those ngrams concatenated are returned

    ## Example

      iex> FoxboxNGrams.Iterative.do_ngrams_permutation(["Show", "me", "the"])
      ["Show", "Show me", "Show me the", "me", "me the", "the"]
  """
  @spec do_ngrams_permutation(list(String.t)) :: list(String.t)
  defp do_ngrams_permutation([]), do: []
  defp do_ngrams_permutation(tokens) do
    total_tokens = length(tokens)

    0..(total_tokens - 1)
    |> Enum.flat_map(& ngrams_from_token(tokens, &1))
  end

  _ = """
    Generates the ngrams from the list of tokens starting from a particular token (given by first_token_position).

    ## Example

    iex> FoxboxNGrams.Iterative.ngrams_from_token(["Show", "me", "the", "code"], 1)
    ["me", "me the", "me the code"]
  """
  @spec ngrams_from_token(list(String.t), integer()) :: list(String.t)
  defp ngrams_from_token(tokens, first_token_position) do
    tokens
    |> Enum.slice(first_token_position, length(tokens))
    |> ngrams()
  end

  _ = """
    This function is in charge of generating the ngrams for a list of tokens.
    Each ngram is generated including a new token in each step.

    ## Example

      iex> FoxboxNGrams.Iterative.ngrams(["Show", "me", "the", "code"])
      ["Show", "Show me", "Show me the", "Show me the code"]
  """
  @spec ngrams(list(String.t)) :: list(String.t)
  defp ngrams(tokens) do
    1..length(tokens)
    |> Enum.map(& build_n_gram(tokens, &1))
  end

  _ = """
    Takes the first n tokens, and joins them as string.

    ## Example

      iex> FoxboxNGrams.Iterative.build_n_gram(["Show", "me", "the", "code"], 3)
      "Show me the"
  """
  @spec build_n_gram(list(String.t), integer()) :: String.t
  defp build_n_gram(tokens, n) do
    tokens
    |> take_first_n(n)
    |> join_tokens()
  end

  _ = """
    Takes the list of tokens, and only returns the first n elements.
  """
  @spec take_first_n(list(String.t), integer()) :: list(String.t)
  defp take_first_n(tokens, n), do: Enum.take(tokens, n)

  @spec join_tokens(list(String.t)) :: String.t
  defp join_tokens(tokens), do: Enum.join(tokens, " ")
end
