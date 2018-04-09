# brew update
# brew install elixir
# \curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s
# vi ~/.zshrc add:
# test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"
# kiex list
# kiex install 1.4
# mix deps.get -> bundle install
# iex -S mix   -> rails s
# iex -S mix phoenix.server


# mix
mix hex.search PACKAGE

# quantum like the cron
Quantum.add_job("* * * * *", fn -> IO.puts "test" end)

# Install dependencies with mix deps.get
# Create and migrate your database with mix ecto.create && mix ecto.migrate
# Install Node.js dependencies with npm install
# Start Phoenix endpoint with mix phoenix.server
# Now you can visit localhost:4000 from your browser.

# iex

# h(Enum)
# ​h(Enum.map)
# ​h(Enum.reverse/1)
# i("hello")
# ​
# ​b/1            - prints callbacks info and docs for a given module
# ​c/1            - compiles a file into the current directory
# ​c/2            - compiles a file to the given path
# ​cd/1           - changes the current directory”
# clear/0        - clears the screen
# exports/1      - shows all exports (functions + macros) in a module
# flush/0        - flushes all messages sent to the shell
# h/0            - prints this help message
# h/1            - prints help for the given module, function or macro
# i/0            - prints information about the last value
# i/1            - prints information about the given term
# ls/0           - lists the contents of the current directory
# ls/1           - lists the contents of the specified directory
# open/1         - opens the source for the given module or function
#                  in your editor
# pid/1          - creates a PID from a string
# pid/3          - creates a PID with the 3 integer arguments passed
# ref/1          - creates a Reference from a string
# ref/4          - creates a Reference with the 4 integer arguments
#                  passed
# pwd/0          - prints the current working directory
# r/1            - recompiles the given module's source file
# recompile/0    - recompiles the current project
# runtime_info/0 - prints runtime info (versions, memory usage, stats)
# v/0            - retrieves the last value from the history
# v/1            - retrieves the nth value from the history

##
10 / 5      # => 2.0 float
div(10, 5)  # => 2   integer
0xFF        # => 255
0xFF + 0x02 # => 257
##

# parallel map
def pmap(collection, func) do
  collection
  |> Enum.map(&(Task.async(fn -> func.(&1) end)))
  |> Enum.map(&Task.await/1)
end

## Pattern Matching ##
[a, b, c] = [1, 2, [3, 4, 5]] # a == 1, b == 2, c == [3, 4, 5]

a = 99
[^a, b, c] = [1, 2, 3] # ** (MatchError) no match of right hand side value: [1, 2, 3]
####
[4 | [1, 2, 3]] # => [4, 3, 2, 1]
####
{a, b, c} = {1, 2, 3}
####

###
Macro.to_string(12) # => "12"
###

## Metaprogramming
# quoting
quote do: sum(1, 2 + 3, 4) # => {:sum, [], [1, {:+, [context: Elixir, import: Kernel], [2, 3]}, 4]}
# :sum         # => Atoms
# 1.0          # => Numbers
# [1, 2]       # => Lists
# "strings"    # => Strings
# {key, value} # => Tuples with two elements

quote do: %{1 => 2, 2 => 3, 3 => 4} # => {:%{}, [], [{1, 2}, {2, 3}, {3, 4}]}
#

# Unquoting
#Macro.to_string(quote do: 11 + unquote(13)) # => "11 + 13"

# Escaping
map = %{hello: :world}
Macro.escape(map) # => {:%{}, [], [hello: :world]}
##

# if/else
if(length(list) == 0) do
  nil
else
  hd(list)
end
#
unless(length(list) == 0) do
  hd(list)
end
#
if true, do: 1, else: 2
if(length(list) == 0, do: nil, else: hd(list))
##

# cond
cond do
     day == :Monday  -> "M"
     day == :Tuesday -> "Tu"
     true            -> "Invalid day"
     end
##

# pm
 def some_day(:Monday),  do: 'M'
 def some_day(:Tuesday), do: 'Tu'
 def some_day(_),        do: 'Invalid day'
#

# case
case day do
         :Monday  -> "M"
         :Tuesday -> "Tu"
         _        -> "Invalid day"
         end

case day do
         {1, _, _}                      -> "Brand new month"
         {25, 12, _}                    -> "Marry Cristmas"
         {_, month, _} when month <= 12 -> "Just day"
         {_, _, _}                      -> "Invalid month"
         end
##

# recursion
def map([], _), do: []
def map([hd | tl], f), do: [f.(hd) | map(tl, f)]
#
def lyrics(), do: lyrics(100..1)
def lyrics(first..last) when first <= last, do: get_sentence(first)
def lyrics(first..last), do: get_sentence(first) <> lyrics(first - 1..last)
#
import Kernel, except: [length: 1]

def length([]), do: 0
def length([_ | tail]), do: 1 + length(tail)
# tail resursion
def other_length([_ | tail]),      do: other_length(tail, 1)
def other_length([], len),         do: len
def other_length([_ | tail], len), do: other_length(tail, len + 1)
##
def reverse(l), do: reverse(1, [])
def reverse([], reversed), do: reversed
def reverse([head | tail], reversed), do: reverse(tail, [head reversed])


def other_map([head | tail], f),         do: other_map(tail, f, [f.(head)])
def other_map([], _, result),            do: reverse(result)
def other_map([head | tail], f, result), do: other_map(tail, f, [f.(head) | result])

Xxx.other_map([1, 2, 3], &(&1 * 2)) # => [6, 4, 2]
##

## TypeCheck functions
is_atom/1
is_binary/1
is_bitstring/1
is_boolean/1
is_float/1
is_function/1
is_function/2
is_integer/1
is_list/1
is_map/1
is_ni1/1
is_number/1
is_pid/1
is_port/1
is_reference/1
is_tuple/1

## Additional functions
abs(number)
binary_part(binary, start, length)
bit_size(bitstring)
byte_size(bitstring)
div(integer, integer)
elem(tuple, n)
hd(list)
length(list)
map_size(map)
node()
node(pid | ref | port)
rem(integer, integer)
round(number)
self()
tl(list)
trunc(number)
tuple_size(tuple)

## Types
## Atoms
# :fred​ ​:is_binary?​ ​:var@2​  ​:<>​  ​:===​  ​:"func/3"​ :"long john silver"​
# :nil
# :true
# :false
# true == :true # => true

# String
"Test #{[1, 2, 3]}" # => <<84, 101, 115, 116, 32, 1, 2, 3>>

## Lists
[a, b, c, d] = [1 | [2 | [3, 4]]] # => [1, 2, 3, 4]
options = [{:success, true}, {:fail, false}] # => [success: true, fail: false]
options[:success]                            # => true

Enum.at([:a, :b, :c, :d], 2)     # => :c
Enum.fetch([:a, :b, :c, :d], 2)  # =>{ :ok, :c }
Enum.fetch!([:a, :b, :c, :d], 2) # => { :ok, :c }
#
languages = ['Elixir', 'Java', 'Ruby']
List.insert_at(languages, 0, 'C++')
languages # => ['Elixir', 'Java', 'Ruby'] # elixir is immutable, we need to rebind variable
languages = List.insert_at(languages, 0, 'C++')

## Maps
my_map = %{{:x, :y} => [1, 2, 3], 1 => {'a', 'b', 'c'}, :a => '123', 'b' => 123}
my_map.a        # => '123'
my_map['b']     # => 123
elem(my_map, 2) # => '123'

map       = %{:digits => [1, 2, 3]}  # => %{digits: [1, 2, 3]}
other_map = %{:digits => list} = map # => %{digits: [1, 2, 3]}
list                                 # => [1, 2, 3]
## Range
1..5
##

## Regexp
~r{regexp}
~r/…/

Regex.run ~r{[aeiou]}, "caterpillar"          # => ["a"]                                    ​ 
Regex.scan ~r{[aeiou]}, "caterpillar"​         # => [["a"], ["e"], ["i"], ["a"]]                                                                                                        ​ 
Regex.split ~r{[aeiou]}, "caterpillar"​        # => ["c", "t", "rp", "ll", "r"]
Regex.replace ~r{[aeiou]}, "caterpillar", "*" # => "c​*​t​*​rp​*​ll​*​r
##

## Tuple
xxx = {'one', :two, 3}
elem(xxx, 0)                    # => "one"
yyy = put_elem(xxx, 2, 'three') # => {'one', :two, 'three'}
xxx                             # => {'one', :two, 3}

{status, result} = File.open("") #=> {:error, :enoent}
{status, result} = File.open("/shit.json") #=> {:ok, #PID<0.267.0>}
status # => :ok
##


####
# iex "module_playground.ex" => run file
# r("module_playground.ex")  => reload ModulePlayground module
# import_file("module_playground.ex")
#
defmodule ModulePlayground do
  def say_here do
    IO.puts("I am here")
  end
end

defmodule ModulePlayground do
  import IO, only: [puts: 1]
  import Kernel, except: [inspect: 1] # because we override this method

  def say_here do
    inspect "I am here" # without module
  end

  def inspect(param1) do
    puts param1
  end
end

ModulePlayground.say_here

# aliases
defmodule ModulePlayground do
  def print_sum do
    ModulePlayground.Misc.Util.Math.add(1, 2)
  end
end

defmodule ModulePlayground do
  alias ModulePlayground.Misc.Util.Math

  def print_sum do
    Math.add(1, 2)
  end
end

defmodule ModulePlayground do
  alias ModulePlayground.Misc.Util.Math, as: MyMath

  def print_sum do
    MyMath.add(1, 2)
  end
end

# require
defmodule ModulePlayground do
  require Integer # allow to use macros

  def even?(arg) do
    Integer.is_even(arg)
  end
end

# Macros
# Numbers
Integer.is_even(5) # => false

###

## functions
defmodule Sample.Enum do
  def first([]), do: nil
  def first([head | _]) do
    head
  end

  def some_func(quantity, {_, _, price}) do
    quantity * price
  end
  def some_func(quantity, book) do
    quantity * elem(book, 2)
  end
end

Sample.Enum.first([1, 2, 3]) # => 1
## Operators
[1, 2, 3] ++ [4, 5, 6] # => [1, 2, 3, 4, 5, 6]
[1, 2, 3, 2] -- [2]    # => [1, 3, 2]
"foo" <> "bar"         # => "foobar"
1 == 1.0               # => true
1 === 1.0              # => false
###


# Guard Clauses
def first(list) when length(list) == 0, do: nil # if list length == 0, else:
def first([head | _]), do: head
###

# Default parameters
def first([], val \\ nil), do: val
def add(list, val \\ 0), do: [val | list]

# private functions
  defp some_function, do: nil

# Functions as First-class citizens
list = [1, 2, 3, 4]
Enum.map(list, &Sample.Utils.square/1)    # => [1, 4, 9, 16]
Enum.reduce(list, 0, &Sample.Utils.sum/2) # => 10

# Anonymous functions
Enum.map(list, fn(x) -> x * x end)              # => [1, 4, 9, 16]
Enum.reduce(list, 0, fn(x, acc) -> acc + x end) # => 10

Enum.map(list, &(&1 * &1))       # => [1, 4, 9, 16]
Enum.reduce(list, 0, &(&1 + &2)) # => 10

#
defmodule Sample.Utils do
  def square(a), do: a * a
  def sum(a, b), do: a + b
  def custom_func(a, f) do
    f.(a)
  end
end
Any chance you can do it it’s just a technical conversation for this week
Sample.Utils.custom_func(1, fn(x) -> IO.puts(x) end) # => 1
#


###!!###
defmodule Account do
  def balance(initial, spending) do
    discount(initial, 10) |> interest(0.1) #discount(initial, 10) |> interest(..., 0.1)
  end

  def discount(a, b) do
    a+b
  end

  def interest(a, b) do
    a+b
  end
end

def balance(initial, spending) do
  discount(initial, 10)
  |> interest(0.1)
  |> format("$")
end

def print_sum do
  1..10
  |> Enum.sum
  |> IO.puts
end

################
IO.puts String.upcase('Elixir')

##or##

"Elixir"
|> String.upcase
|> IO.puts
################


#################
defmodule Person do
  def format_name(full_name) do
    full_name
    |> String.split
    |> format
  end

  def format(parts) do
    first = Enum.at(parts, 0)
    last = Enum.at(parts, 1)
    "#{String.upcase(last)}, #{first}"
  end
end

IO.puts Person.format_name("José Valim")
########################

####
name     = "​​elixir"​
cap_name = String.capitalize(name)
IO.puts cap_name # => ​​ELIXIR
IO.puts name     # => ​​elixir
​####
last_name = "Valim"
IO.puts last_name

"Jose " <> last_name = "Jose Valim"
IO.puts last_name

data = ['Elixir', 'Jose']
[a, b] = data

IO.puts "#{a}, #{b}" ##Elixir, Jose

defmodule Account do
  def run_transaction(balance, amount, type) do
    if type == :deposit do
      balance + amount
    else
      balance - amount
  end
end

Account.run_transaction(1000, 50, :deposit) ##1050
Account.run_transaction(1000, 30, :withdrawl) ##1020

## or ##
defmodule Account do
  def run_transaction(balance, amount, :deposit) do
    balance + amount
  end

  def run_transaction(balance, amount, :withdrawl) do
    balance + amount
  end
end
####################
