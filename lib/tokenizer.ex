defmodule FoxboxNGrams.Tokenizer do
  @moduledoc """
    This module is in charge to tokenize any text to be used in the Foxbox N-Grams
  """

  def tokenize(text) do
    text
    |> strip_punctuation()
    |> split_text()
  end

  defp strip_punctuation(text), do: String.replace(text, ~r/\p{P}/, "")
  defp split_text(""), do: []
  defp split_text(text), do: String.split(text, " ")
end
