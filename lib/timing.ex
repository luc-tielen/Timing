defmodule Timing do
  
  @moduledoc """
  Module for timing a block of code easily.
  Inspiration came from this Erlang article:
  https://erlangcentral.org/wiki/index.php/Measuring_Function_Execution_Time
  """

  @doc false
  defmacro __using__(_opts) do
    quote do
      import Timing
    end
  end

  @doc """
  Macro for easily timing functions.
  Returns a tuple of the form {T, R}:
    - T: the elapsed time in milliseconds to execute this block of code
    - R: the result from the block of code
  """
  defmacro time(do: block) do
    quote do
      :timer.tc fn ->
        unquote(block)
      end
    end
  end

  @doc """
  Measures the time taken for executing a certain block of code X amount of
  times and calculates certain statistics.
  
  NOTE: this function call should not be used in production code, it's only
  meant for measuring statistics about a block of code...

  Returns a tuple of the form: {AVG, MIN, MAX, MEDIAN, RESULT}:
    - AVG: average time needed
    - MIN: minimum time needed
    - MAX: maximum time needed
    - MEDIAN: median time needed
    - RESULT: actual result of calling this block of code for the first time
  """
  defmacro time_avg(amount, do: block) when is_integer(amount) do
    quote do
      result = for _ <- 1..unquote(amount) do
        time do
          unquote(block)
        end
      end

      timings = Enum.map result, fn {timing, _result} -> timing end
      min = Enum.min timings
      max = Enum.max timings
      avg = Enum.sum(timings) / unquote(amount)
      median = timings |> Enum.sort |> Enum.at (div unquote(amount), 2)

      [{_, first_result} | _] = result
      {avg, min, max, median, first_result}
    end
  end
end
