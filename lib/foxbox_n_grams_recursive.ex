defmodule FoxboxNGrams.Recursive do
  @moduledoc """
    This module provides a recursive solution to the Foxbox N-Grams Code Challenge
  """

  alias FoxboxNGrams.Tokenizer

  @doc """
    Tokenizes and generates a set of every permutation of contiguous n-grams from a string of text,
    from 1-gram to n-grams where n is the number of words in the text

    ## Example

      iex> FoxboxNGrams.Recursive.ngrams_permutation("Show me the code.")
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
  @spec ngrams_permutation(String.t) :: list(String.t)
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

      iex> FoxboxNGrams.Recursive.do_ngrams_permutation(["Show", "me", "the"])
      ["Show", "Show me", "Show me the", "me", "me the", "the"]
  """
  @spec do_ngrams_permutation(list(String.t), list(String.t)) :: list(String.t)
  defp do_ngrams_permutation(tokens, permutations \\ [])
  defp do_ngrams_permutation([], permutations), do: permutations
  defp do_ngrams_permutation([_ | tail_token] = tokens, permutations) do
    do_ngrams_permutation(tail_token, permutations ++ ngrams(tokens))
  end

  _ = """
    This function is in charge of generating the ngrams for a list of tokens.
    Each ngram is generated including a new token in each step.

    ## Example

      iex> FoxboxNGrams.Recursive.ngrams(["Show", "me", "the", "code"])
      ["Show", "Show me", "Show me the", "Show me the code"]
  """
  @spec ngrams(list(String.t), list(String.t), list(String.t) | nil) :: list(String.t)
  defp ngrams(all_tokens, ngrams_accumulator \\ [], work_tokens \\ nil)
  defp ngrams([head | _] = all_tokens, [], nil), do: ngrams(all_tokens, [], [head])
  defp ngrams(all_tokens, ngrams_accumulator, work_tokens) when all_tokens == work_tokens, do: ngrams_accumulator ++ [join_tokens(work_tokens)]
  defp ngrams(all_tokens, ngrams_accumulator, work_tokens) do

    # Generates a new list of work tokens to be processed recursively.
    # This one has a new token at the end of the list, taken from the original list of tokens.
    # When work_tokens has the value ["Show", "me"] the expanded would be ["Show", "me", "the"]
    next_work_tokens = expand_elements(all_tokens, work_tokens)

    ngrams(all_tokens, ngrams_accumulator ++ [join_tokens(work_tokens)], next_work_tokens)
  end

  @spec expand_elements(list(String.t), list(String.t), integer()) :: list(String.t)
  defp expand_elements(all_tokens, work_tokens, total \\ 1), do: Enum.take(all_tokens, length(work_tokens) + total)

  @spec join_tokens(list(String.t)) :: String.t
  defp join_tokens(tokens), do: Enum.join(tokens, " ")
end
