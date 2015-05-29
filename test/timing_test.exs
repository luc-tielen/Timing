defmodule TimingTest do
  use ExUnit.Case
  use Timing

  test "time macro" do
    {elapsed_time, timed_result} = time do
      Enum.sum 1..100
    end

    normal_result = 5050
    assert timed_result == normal_result
    assert elapsed_time >= 0
  end

  test "time_avg macro" do
    {avg, min, max, median, first_result} = time_avg 1_000 do
      x = "123456789"
      "test" <> x
    end
    
    assert first_result == "test123456789"
    assert avg >= 0 and min >= 0 and max >= 0 and  median >= 0
    assert max >= avg and avg >= min
  end
end
