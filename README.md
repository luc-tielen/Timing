# Timing

Very compact timing module for quickly testing speed of certain parts of your
codebase.

## Installing

Add the following to your mix.exs:

```elixir
def deps do
  [{:timing, git: "git://github.com/Primordus/Timing.git"}, 
   ...  # Other dependencies here..
  ]
end
```

## Examples

```elixir
# Top of module
use Timing

# ... code ...

# Elapsed time is the time elapsed in milliseconds,
# timed_result = the same result the block of code normally would've had.
{elapsed_time, timed_result} = time do
    Enum.sum 1..100
end
```

The time macro is a very simple macro which wraps the block of code with a
timing function. It executes the code only, meaning the measurements might
differ slightly each execution. 

If more precision is needed, consider using the
time_avg macro. This macro will execute the block of code X amount of 
times and calculate statistics like minimum, maximum, average and median 
time needed to execute that specific block of code.

```elixir
# Top of module
use Timing

# ... code ...

{avg, min, max, median, first_result} = time_avg 1_000 do  # also returns first result which can for example be used in further tests..
  x = "123456789"
  "test" <> x
end
```

