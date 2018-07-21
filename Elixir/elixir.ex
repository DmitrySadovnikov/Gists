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
Regex.scan ~r{[aeiou]}, "caterpillar"         # => [["a"], ["e"], ["i"], ["a"]]                                                                                                        ​ 
Regex.split ~r{[aeiou]}, "caterpillar"        # => ["c", "t", "rp", "ll", "r"]
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

# sleep
defmodule Countdown do
  def sleep(seconds) do
    receive do
    after seconds * 1000 -> nil
    end
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
String.capitalize("name") # => Name
String.upcase("Elixir")   # => ELIXIR
################

########################
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

########################
last_name = "Valim"
IO.puts last_name

"Jose " <> last_name = "Jose Valim"
IO.puts last_name

data = ["Elixir", "Jose"]
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


# book ->
#### List (Array) ####
[1, 2] ++ [3, 4]                         # => [1, 2, 3, 4]
[1, 2, 3, 4] -- [3, 4]                   # => [1, 2]
1 in [1, 2, 3]                           # => true

List.foldl([1,2,3], "", &"#{&1}(#{&2})") # => "3(2(1()))"
List.foldr([1,2,3], "", &"#{&1}(#{&2})") # => "1(2(3()))"

List.flatten([[[1], 2], [[3]]])          # => [1, 2, 3]
List.replace_at([1,2,3], 2, "three")     # => [1, 2, "three"]

kw = [{:key1, "val1"}, {:key2, "val2"}]
List.keyfind(kw, "val1", 1)                   # => {:key1, "val1"}
List.keydelete(kw, "val1", 1)                 # => [key2: "val2"]
List.keyreplace(kw, "val1", 1, {:xxx, "XXX"}) # => [xxx: "XXX", key2: "val2"]
########

#### Maps ####
map = %{name: "Dave", likes: "Programming", where: "Dallas"}
Map.keys map   # => [:likes, :name, :where]
Map.values map # => ["Programming", "Dave", "Dallas"]

Map.has_key? map, :name # => true

map.name   # => "Dave"
map[:name] # => "Dave"

Map.drop map, [:where, :likes]   # => %{name: "Dave"}
Map.put map, :also_likes, "Ruby" # => %{also_likes: "Ruby", likes: "Programming", name: "Dave", where: "Dallas"}

Map.equal? map, %{} # => false
Map.pop map, :likes # => {"Programming", %{name: "Dave", where: "Dallas"}}
########

#### Binaries ####
bin = <<1, 2>> # => << 1, 2 >>
byte_size bin  # => 2

bin = <<3 :: size(2), 5 :: size(4), 1 :: size(2)>> # => <<213>>
:io.format("~-8.2b~n", :binary.bin_to_list(bin))   # => 11010101
byte_size bin                                      # => 1
<<1, 2>> <> <<3, 4>>                               # => <<1, 2, 3, 4>>
########

#### Dates and Times ####
# date
{:ok, d1} = Date.new(2018, 12, 25) # => {:ok, ~D[2018-12-25]}
Date.day_of_week(d1)               # => 2
Date.add(d1, 7)                    # => ~D[2019-01-01]
inspect d1, structs: false         # => "%{__struct__: Date, calendar: Calendar.ISO, day: 25, month: 12, year: 2018}"

# range
first_half = Date.range(~D[2018-01-01], ~D[2018-06-30]) # => #DateRange<~D[2018-01-01], ~D[2018-06-30]>
Enum.count(first_half)                                  # => 181
~D[2018-03-15] in first_half                            # => true

# time
{:ok, t1} = Time.new(12, 34, 56) # => {:ok, ~T[12:34:56]}
t2 = ~T[12:34:56.78]             # => ~T[12:34:56.78]
t1 == t2                         # => false
Time.add(t1, 3600)               # => ~T[13:34:56.000000]
Time.add(t1, 3600, :millisecond) # => ~T[12:34:59.600000]
########

#### with ####
lp = with {:ok, file}   = File.open("fuck.json"),
          content       = IO.read(file, :all),
          :ok           = File.close(file),
          [_, uid, gid] = Regex.run(~r/^_lp:.*?:(\d+):(\d+)/, content)
  do
    "Group: #{gid}, User: #{uid}"
  end
IO.puts lp      # => Group: 26, User: 26
IO.puts content # => Some content
#
with [a|_] <- [1, 2, 3], do: a # => 1
with [a|_] <- nil,       do: a # => nil
#
mean = with count = Enum.count(values),
            sum   = Enum.sum(values)
       do
         sum/count
       end
#
mean = with(
  count = Enum.count(values),
  sum = Enum.sum(values)
    do
    sum / count
  end
)
#
mean = with count = Enum.count(values),
            sum   = Enum.sum(values),
       do: sum / count
########


#### anonymous function ####
sum = fn (a, b) -> a + b end # => #Function<12.99386804/2 in :erl_eval.expr/5>
sum.(1, 2)                   # => 3
#
handle_open = fn
  {:ok, file} -> "File line: #{IO.read(file, :line)}"
  {_, error}  -> "Error: #{:file.format_error(error)}"
end
IO.puts handle_open.(File.open("some_path"))
# function returns function
fun1 = fn -> fn -> "Hello" end end
fun1.().() # => "Hello"
# function as argument
times_2 = fn n -> n * 2 end
apply   = fn(fun, value) -> fun.(value) end
apply.(times_2, 6) # => 12
#
Enum.map [1, 2, 3], fn e -> e * 2 end # => [2, 4, 6]
#
fn
  (^name) -> "#{greeting} #{name}"
  (_)     -> "I don't know you"
end
########

#### The & Notation
add_one = &(&1 + 1) # same as fn(n) -> n + 1 end
add_one.(44)        # => 45

speak = &(IO.puts(&1))
speak.("Hello") # => Hello

rnd = &(Float.round(&1, &2)) # => &Float.round/2
rnd.(2.22222222, 2)          # => 2.22

direm = &{div(&1, &2), rem(&1, &2)}
direm.(13, 5) # => {2, 3}

s = &"bacon and #{&1}"
s.("custard") # => "bacon and custard"

match_end = &~r/.*#{&1}$/
"cat" =~ match_end.("t") # => true
"cat" =~ match_end.("!") # => false

l = &length/1    # => &:erlang.length/1
l.([1, 2, 3, 4]) # => 4

m = &Kernel.min/2 # => &:erlang.min/2
m.(99, 88)        # => 88

Enum.map [1, 2, 3, 4], &(&1 + 1) # => [2, 3, 4, 5]
########

#### Guards ####
defmodule Guard do
  def what_is(x) when is_number(x) do
    IO.puts "#{x} is a number"
  end
  def what_is(x) when is_list(x) do
    IO.puts "#{inspect(x)} is a list"
  end
  def what_is(x) when is_atom(x) do
    IO.puts "#{x} is a atom"
  end
end
Guard.what_is([1, 2, 3]) # => [1, 2, 3] is a list
#
defmodule Factorial do
  def of(0), do: 1
  def of(n) when(is_integer(n) and n > 0), do: n * of(n - 1)
end
########

#### Module Attributes ####
defmodule Example do
  @author "Dave Thomas"
  def get_author do
    @author
  end
end
########

#### Calling a Function from Erlang Libruary ####
:io.format("The number is ~3.1f~n", [5.678]) # The number is 5.7
########

#### Head and Tail ####
defmodule MyList do
  def square([]), do: []
  def square([head | tail]), do: [head * head | square(tail)]

  def reduce([], value, _), do: value
  def reduce([head | tail], value, func), do: reduce(tail, func.(head, value), func)
end
MyList.square([4, 5, 6])                # => [16, 25, 36]
MyList.reduce([4, 5, 6], 1, &(&1 * &2)) # => 120
########


#### Inspect ####
arr = [%{a: 4, b: "b"}, %{a: 6, b: "b"}]          # => [%{a: 4, b: "b"}, %{a: 6, b: "b"}]
IO.inspect(for p = %{a: a} <- arr, a > 5, do: p ) # => [%{a: 6, b: "b"}]
#
IO.inspect(for p <- [5, 6, 7], p > 5, do: p) # => [6, 7]
########


#### pattern matching ####
# match variables keys
data = %{name: "Dave", state: "TX", likes: "Elixir"}

for key <- [:name, :like] do
  %{ ^key => value } = data
  value
end
# => ["Dave", "Elixir"]
########

#### Updating a Map ####
m  = %{a: 1, b: 2, c: 3}         # => %{a: 1, b: 2, c: 3}
m1 = %{m | b: "two", c: "three"} # => %{a: 1, b: "two", c: "three"}
m2 = %{m1 | a: "one"}            # => %{a: "one", b: "two", c: "three"}
########

#### Struct ####
defmodule Subscriber do
  defstruct name: "", paid: false, over_18: true
end
s1 = %Subscriber{}                         # => %Subscriber{name: "", paid: false, over_18: true}
s2 = %Subscriber{name: "Dave"}             # => %Subscriber{name: "Dave", paid: false, over_18: true}
s3 = %Subscriber{name: "Mary", paid: true} # => %Subscriber{name: "Mary", paid: true, over_18: true}
s4 = %Subscriber{s3 | name: "Marie"}       # => %Subscriber{name: "Marie", paid: true, over_18: true}v

s3.name # => "Mary"
%Subscriber{name: a_name} = s3
a_name # => "Mary"
##
defmodule Attendee do
  defstruct name: "", paid: false, over_18: true

  def may_attend_after_party(attendee = %Attendee{}), do: attendee.paid && attendee.over_18

  def print_vip_badge(%Attendee{name: name}) when name != "", do: "Hello #{name}"
  def print_vip_badge(_), do: IO.puts "missing name for badge"
end
a1 = %Attendee{name: "Dave", over_18: true}
Attendee.may_attend_after_party(a1) # => false
##
defmodule Customer do
  defstruct name: "", company: ""
end
defmodule BugReport do
  defstruct owner: %Customer{}, details: "", severity: 1
end
owner = %Customer{company: "XXX", name: "YYY"}
# => %Customer{company: "XXX", name: "YYY"}
report = %BugReport{owner: owner}
# => %BugReport{details: "", owner: %Customer{company: "XXX", name: "YYY"}, severity: 1}
report = %BugReport{report | owner: %Customer{report.owner | company: "PragProg"}}
# => %BugReport{details: "", owner: %Customer{company: "PragProg", name: "YYY"}, severity: 1}
owner # => %BugReport{details: "", owner: %Customer{company: "XXX", name: "YYY"}, severity: 1}

# add value
put_in(report.owner.company, "PragProg")      # => %Customer{company: "PragProg", name: "Dave", severity: 1}

# change value with nested function
update_in(report.owner.name, &("Mr. " <> &1)) # => %BugReport{details: "", owner: %Customer{company: "XXX", name: "Mr. YYY"}, severity: 1}

get_in
nested = %{
  buttercup: %{
    actor: %{
      first: "Robin",
      last: "Wright"
    },
    role: "princess"
  },
  westley: %{
    actor: %{
      first: "Cary",
      last: "Ewles"
    },
    role: "farm boy"
  }
}
IO.inspect get_in(nested, [:buttercup])
# => %{actor: %{first: "Robin", last: "Wright"}, role: "princess"}
IO.inspect get_in(nested, [:buttercup, :actor]) # => %{first: "Robin", last: "Wright"}
IO.inspect get_in(nested, [:buttercup, :actor, :first]) # => "Robin"
IO.inspect put_in(nested, [:westley, :actor, :last], "Elwes")
# => %{buttercup: %{actor: %{first: "Robin", last: "Wright"}, role: "princess"}
# => westley: %{actor: %{first: "Cary", last: "Elwes"}, role: "farm boy"}}
IO.inspect get_in(authors, [some_function, :some_arg])
get_and_update_in
########


#### Access Module ####
cast = [
  %{
    character: "Buttercup",
    actor: %{
      first: "Robin",
      last: "Wright"
    },
    role: "princess"
  },
  %{
    character: "Westley",
    actor: %{
      first: "Cary",
      last: "Elwes"
    },
    role: "farm boy"
  }
]
IO.inspect get_in(cast, [Access.all(), :character]) #=> ["Buttercup", "Westley"]
IO.inspect get_in(cast, [Access.at(1), :role]) #=> "farm boy"
IO.inspect get_and_update_in(
             cast,
             [Access.all(), :actor, :last],
             fn (val) -> {val, String.upcase(val)} end
           )
IO.inspect get_in(cast, [Access.key(:westley), :actor, Access.elem(1)]) #=> "Elwes"
Access.pop(%{name: "Elixir", creator: "Valim"}, :name) # => {"Elixir", %{creator: "Valim"}}
Access.pop([name: "Elixir", creator: "Valim"], :name)  # => {"Elixir", [creator: "Valim"]}
Access.pop(%{name: "Elixir", creator: "Valim"}, :year) # => {nil, %{creator: "Valim", name: "Elixir"}}
########

#### Sets ####
set1 = 1..5 |> Enum.into(MapSet.new) # => #MapSet<[1, 2, 3, 4, 5]>
set2 = 3..8 |> Enum.into(MapSet.new) # => #MapSet<[3, 4, 5, 6, 7, 8]>

MapSet.member? set1, 3         # => true
MapSet.union set1, set2        # => #MapSet<[1, 2, 3, 4, 5, 6, 7, 8]>
MapSet.difference set1, set2   # => #MapSet<[1, 2]>
MapSet.difference set2, set1   # => #MapSet<[6, 7, 8]>
MapSet.intersection set2, set1 # => #MapSet<[3, 4, 5]>
########

#### Keyword ####
options = [{:width, 72}, {:width, 454}] # => [width: 72, width: 454]
Keyword.get_values(options, :width)     # => [72, 454]
########

#### Enum ####
list = Enum.to_list 1..5 # => [1, 2, 3, 4, 5]

# Concatenate collections:
Enum.concat([1,2,3], [4,5,6]) # => [1, 2, 3, 4, 5, 6]
Enum.concat [1,2,3], 'abc'    # => [1, 2, 3, 97, 98, 99]

#Create collections whose elements are some function of the original:
Enum.map(list, &(&1 * 10))                 # => [10, 20, 30, 40, 50]
Enum.map(list, &String.duplicate("*", &1)) # => ["*", "**", "***", "****", "*****"]

# Select elements by position or criteria:
Enum.at(10..20, 3)                    # => 13
Enum.at(10..20, 20)                   # => nil
Enum.at(10..20, 20, :no_one_here)     # => :no_one_here
Enum.filter(list, &(&1 > 2))          # => [3, 4, 5]
require Integer                       # to get access to is_even nil
Enum.filter(list, &Integer.is_even/1) # => [2, 4]
Enum.reject(list, &Integer.is_even/1) # => [1, 3, 5]

#Sort and compare elements:
Enum.sort ["there", "was", "a", "crooked", "man"] # => ["a", "crooked", "man", "there", "was"]
Enum.sort ["there", "was", "a", "crooked", "man"], &(String.length(&1) <= String.length(&2))
# => ["a", "was", "man", "there", "crooked"]

Enum.max ["there", "was", "a", "crooked", "man"]                      # => "was"
Enum.max_by ["there", "was", "a", "crooked", "man"], &String.length/1 # => "crooked"

# Split a collection:
Enum.take(list, 3)                # => [1, 2, 3]
Enum.take_every(list, 2 )         # => [1, 3, 5]
Enum.split_while(list, &(&1 < 4)) # => {[1, 2, 3], [4, 5]}

# Join a collection:
Enum.join(list)       # => "12345"
Enum.join(list, ", ") # => "1, 2, 3, 4, 5"

# Predicate operations:
Enum.all?(list, &(&1 < 4)) # => false
Enum.any?(list, &(&1 < 4)) # => true
Enum.member?(list, 4)      # => true
Enum.empty?(list)          # => false

# Merge collections:
Enum.zip(list, [:a, :b, :c])                   # => [{1, :a}, {2, :b}, {3, :c}]
Enum.with_index(["once", "upon", "a", "time"]) # => [{"once", 0}, {"upon", 1}, {"a", 2}, {"time", 3}]

# Fold elements into a single value:
Enum.reduce(1..100, &(&1 + &2)) # => 5050
Enum.reduce(
  ["now", "is", "the", "time"],
  fn word, longest ->
    if String.length(word) > String.length(longest) do
      word
    else
      longest
    end
  end
) # => "time"
Enum.reduce(
  ["now", "is", "the", "time"],
  0,
  fn word, longest ->
    if String.length(word) > longest
      do: String.length(word),
      else: longest
  end
) # => 4
# into
Enum.into 1..5, []         # => [1, 2, 3, 4, 5]
Enum.into 1..5, [100, 101] # => [100, 101, 1, 2, 3, 4, 5]
########

#### Streams ####
[1, 2, 3, 4, 5]                                     # => [1, 2, 3, 4, 5]
|> Enum.map(&(&1 * &1))                             # => [1, 4, 9, 16, 25]
|> Enum.with_index                                  # => [{1, 0}, {4, 1}, {9, 2}, {16, 3}, {25, 4}]
|> Enum.map(fn {value, index} -> value - index end) # => [1, 3, 7, 13, 21]
|> IO.inspect                                       # => [1, 3, 7, 13, 21]
##
File.read!("/usr/share/dict/words")
|> String.split
|> Enum.max_by(&String.length/1)
|> IO.puts
##
s = Stream.map(
  [1, 3, 5, 7],
  &(&1 + 1)
) # => #Stream<[enum: [1, 3, 5, 7], funs: [#Function<46.3851/1 in Stream.map/2>]]>
##
s = Stream.map [1, 3, 5, 7], &(&1 + 1) # => #Stream<[enum: [1, 3, 5, 7], funs: [#Function<46.3851/1 in Stream.map/2>] ]>
Enum.to_list s                         # => [2, 4, 6, 8]

squares = Stream.map [1, 2, 3, 4], &(&1*&1)
# => #Stream<[enum: [1, 2, 3, 4], funs: [#Function<32.133702391 in Stream.map/2>] ]>
plus_ones = Stream.map squares, &(&1+1)
# => #Stream<[enum: [1, 2, 3, 4], funs: [#Function<32.133702391 in Stream.map/2>,
                                         #Function<32.133702391 in Stream.map/2>] ]>
odds = Stream.filter plus_ones, fn x -> rem(x,2) == 1 end
# => #Stream<[enum: [1, 2, 3, 4], funs: [#Function<26.133702391 in Stream.filter/2>,
                                         #Function<32.133702391 in Stream.map/2>,
                                         #Function<32.133702391 in Stream.map/2>] ]>
Enum.to_list odds # => [5, 17]

[1, 2, 3, 4]
|> Stream.map(&(&1*&1))
|> Stream.map(&(&1+1))
|> Stream.filter(fn x -> rem(x,2) == 1 end)
|> Enum.to_list

File.open!("/usr/share/dict/words")
|> IO.stream(:line)
|> Enum.max_by(&String.length/1)
|> IO.puts

File.stream!("/usr/share/dict/words")
|> Enum.max_by(&String.length/1)
|> IO.puts

Enum.map(1..10_000_000, &(&1+1))
|> Enum.take(5)
# => [2, 3, 4, 5, 6]

Stream.map(1..10_000_000, &(&1+1))
|> Enum.take(5)
# => [2, 3, 4, 5, 6]

Stream.cycle(~w{ green white })
|> Stream.zip(1..5)
|> Enum.map(
     fn {class, value} ->
       "<tr class='#{class}'><td>#{value}</td></tr>\n"
     end
   )
|> IO.puts
# <tr class="green"><td>1</td></tr>
# <tr class="white"><td>2</td></tr>
# <tr class="green"><td>3</td></tr>
# <tr class="white"><td>4</td></tr>
# <tr class="green"><td>5</td></tr>
# :ok

Stream.repeatedly(fn -> true end) |> Enum.take(3)     # => [true, true, true]
Stream.repeatedly(&:random.uniform/0) |> Enum.take(3) # => [0.7230402056221108, 0.94581636451987, 0.5014907142064751]м
# iterate
Stream.iterate(0, &(&1+1))  |> Enum.take(5) # => [0, 1, 2, 3, 4]
Stream.iterate(2, &(&1*&1)) |> Enum.take(5) # => [2, 4, 16, 256, 65536]
Stream.iterate([], &[&1])   |> Enum.take(5) # => [[], [[]], [[[]]], [[[[]]]], [[[[[]]]]]]

Stream.unfold({0,1}, fn {f1,f2} -> {f1, {f2, f1+f2}} end) |> Enum.take(15)
# => [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]

Stream.resource fn -> File.open("sample") end,
                fn file ->
                  case IO.read(file, :line) do
                    data when is_binary(data) -> {[data], file}
                    _ -> {:halt, file}
                  end
                end,
                fn file -> File.close(file) end
########


#### Comprehensions ####
for x <- [1, 2, 3, 4, 5], do: x * x        # => [1, 4, 9, 16, 25]
for x <- [1, 2, 3, 4, 5], x < 4, do: x * x # => [1, 4, 9]
for x <- [1,2], y <- [5,6], do: {x, y}     # => [{1, 5}, {1, 6}, {2, 5}, {2, 6}]

min_maxes = [{1,4}, {2,3}, {10, 15}]             # => [{1, 4}, {2, 3}, {10, 15}]
for {min,max} <- min_maxes, n <- min..max, do: n # => [1, 2, 3, 4, 2, 3, 10, 11, 12, 13, 14, 15]

first8 = [1, 2, 3, 4, 5, 6, 7, 8] # => [1, 2, 3, 4, 5, 6, 7, 8]
for x <- first8,
    y <- first8,
    x >= y, rem(x * y, 10) == 0,
    do: {x, y} # => [{5, 2}, {5, 4}, {6, 5}, {8, 5}]

reports = [dallas: :hot, minneapolis: :cold, dc: :muggy, la: :smoggy]
# => [dallas: :hot, minneapolis: :cold, dc: :muggy, la: :smoggy]
for {city, weather} <- reports, do: {weather, city}
# => [hot: :dallas, cold: :minneapolis, muggy: :dc, smoggy: :la]

for << ch <- "hello" >>, do: ch     # => 'hello'
for << ch <- "hello" >>, do: <<ch>> # => ["h", "e", "l", "l", "o"]

for << << b1::size(2), b2::size(3), b3::size(3) >> <- "hello" >>, do: "0#{b1}#{b2}#{b3}"
# => ["0150", "0145", "0154", "0154", "0157"]

for x <- ~w{ cat dog }, into: %{}, do: {x, String.upcase(x)} # => %{"cat" => "CAT", "dog" => "DOG"}
########


#### Sigils ####
# ~C A character list with no escaping or interpolation
# ~c A character list, escaped and interpolated just like a single-quoted string ~D A Date in the format yyyy-mm-dd
# ~N A naive (raw) DateTime in the format yyyy-mm-dd hh:mm:ss[.ddd]
# ~R A regular expression with no escaping or interpolation
# ~r A regular expression, escaped and interpolated
# ~S A string with no escaping or interpolation
# ~s A string, escaped and interpolated just like a double-quoted string
# ~T A Time in the format hh:mm:ss[.dddd]
# ~W A list of whitespace-delimited words, with no escaping or interpolation ~w A list of whitespace-delimited words, with escaping and interpolation
~C[1\n2#{1+2}]                  # => '1\\n2\#{1+2}'
~c"1\n2#{1+2}"                  # => '1\n23'
~S[1\n2#{1+2}]                  # => "1\\n2\#{1+2}"
~s/1\n2#{1+2}/                  # => "1\n23"
~W[the c#{'a'}t sat on the mat] # => ["the", "c\#{'a'}t", "sat", "on", "the", "mat"]
~w[the c#{'a'}t sat on the mat] # => ["the", "cat", "sat", "on", "the", "mat"]
~D<1999-12-31>
~D[1999-12-31]
~T[12:34:56]
~T[12:34:56]
~N{1999-12-31 23:59:59}
~N[1999-12-31 23:59:59]
########


#### String ####
String.at("dog", 0)         # => "d"
String.last("dog")          # => "g"
String.length("dog")        # => 3
String.codepoints("dog")    # => ["D", "o", "g"]
String.dublicate("Ho! ", 3) # => "Ho! Ho! Ho!"

String.capitalize("dog") # => "Dog"
String.downcase("Dog")   # => "dog"
String.upcase("Dog")     # => "DOG"

String.start_with?("string", ["elix", "stri", "ring"]) # => true
String.end_with?("string", ["elix", "stri", "ring"])   # => true
String.printable?("\x00 a null")                       # => false
String.valid? 1                                        # => false

String.trim("\t SALE \r\n")             # => "SALE"
String.trim("!!!SALE!!!", "!")          # => "SALE"
String.trim_leading("!!!SALE!!!", "!")  # => "SALE!!!"
String.trim_trailing("!!!SALE!!!", "!") # => "!!!SALE"

String.replace "the cat on the mat", "at", "AT"                          # => "the cAT on the mAT"
String.replace "the cat on the mat", "at", "AT", global: false           # => "the cAT on the mat"
String.replace "the cat on the mat", "at", "AT", insert_replaced: 0      # => "the catAT on the matAT"
String.replace "the cat on the mat", "at", "AT", insert_replaced: [0, 2] # => "the catATat on the matATat"
########


#### PRY ####
require IEx; IEx.pry
binding
continue
break! Buggy.decode/1
breaks
########


#### Test ####
defmodule TestStats1 do
  use ExUnit.Case

  describe "Stats on lists of ints" do
    setup do
      [
        list: [1, 3, 5, 7, 9, 11],
        sum: 36,
        count: 6
      ]
    end

    test "calculates sum", fixture do
      assert Stats.sum(fixture.list) == fixture.sum
    end

    property "single element lists are their own sum" do
      check all number <- integer() do
        assert Stats.sum([number]) == number
      end
    end

    property "sum equals average times count (min_length)" do
      check all l <- list_of(integer(), min_length: 1) do
        assert_in_delta(
          Stats.sum(l),
          Stats.count(l) * Stats.average(l),
          1.0e-6
        )
      end
    end
  end

  describe "Stats on lists of ints" do
    setup do
      {:ok, %{list: [1, 3, 5, 7, 9, 11], sum: 36, count: 6}}
    end

    test "calculates sum", %{list: list, sum: sum, count: count} do
      assert Stats.sum(list) == sum
    end
  end
end
########


#### Process ####
defmodule SpawnBasic do
  def greet do
    IO.puts "Hello" end
end

spawn(SpawnBasic, :greet, [])
##
defmodule Spawn1 do
  def greet do
    receive do
      {sender, msg} -> send sender, {:ok, "Hello, #{msg}"}
    end
  end
end
# here's a client
pid = spawn(Spawn1, :greet, [])

send pid, {self(), "World!"}
receive do
  {:ok, message} -> IO.puts message
end # => Hello, World!

# Handling Multiple Messages
defmodule Spawn2 do
  def greet do
    receive do
      {sender, msg} -> send sender, {:ok, "Hello, #{msg}"}
    end
  end
end
# here's a client
pid = spawn(Spawn2, :greet, [])

send pid, {self(), "World!"}
receive do
  {:ok, message} -> IO.puts message
end

send pid, {self(), "Kermit!"}
receive do
  {:ok, message} -> IO.puts message
end

c("spawn2.exs") # => Hello World!
##
defmodule Spawn3 do
  def greet do
    receive do
      {sender, msg} -> send sender, {:ok, "Hello, #{msg}"}
    end
  end
end
# here's a client
pid = spawn(Spawn3, :greet, [])

send pid, {self(), "World!"}
receive do
  {:ok, message} -> IO.puts message
end

send pid, {self(), "Kermit!"}
receive do
  {:ok, message} -> IO.puts message
after 500 ->
  IO.puts "The greeter has gone away"
end
##
defmodule Chain do
  def counter(next_pid) do
    receive do
      n -> send next_pid, n + 1
    end
  end

  def create_processes(n) do
    code_to_run = fn (_, send_to) ->
      spawn(Chain, :counter, [send_to])
    end

    last = Enum.reduce(1..n, self(), code_to_run)
    send(last, 0) # start the count by sending a zero to the last process

    receive do # and wait for the result to come back to us final_answer when is_integer(final_answer) ->
      "Result is #{inspect(final_answer)}"
    end
  end

  def run(n) do
    :timer.tc(Chain, :create_processes, [n])
    |> IO.inspect
  end

  def sad_function do
    sleep 500
    exit(:boom)
  end
end
elixir -r tmp/xxx.ex -e "Chain.run(10)"
########

#### Scheduler ####
defmodule FibSolver do
  def fib(scheduler) do
    send scheduler, {:ready, self()}
    receive do
      {:fib, n, client} ->
        send client, {:answer, n, fib_calc(n), self()}
        fib(scheduler)
      {:shutdown} -> exit(:normal)
    end
  end

  # very inefficient, deliberately
  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)
end
##
defmodule Scheduler do
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes)
    |> Enum.map(fn (_) -> spawn(module, func, [self()]) end)
    |> schedule_processes(to_calculate, [])
  end

  defp schedule_processes(processes, queue, results) do
    receive do
      {:ready, pid} when length(queue) > 0 ->
        [next | tail] = queue
        send pid, {:fib, next, self()}
        schedule_processes(processes, tail, results)
      {:ready, pid} ->
        send pid, {:shutdown}
        if length(processes) > 1 do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          Enum.sort(results, fn {n1, _}, {n2, _} -> n1 <= n2 end)
        end
      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end
end
##
to_process = List.duplicate(37, 20)

Enum.each 1..10, fn num_processes ->
  {time, result} = :timer.tc(
    Scheduler,
    :run,
    [num_processes, FibSolver, :fib, to_process]
  )

  if num_processes == 1 do
    IO.puts inspect result
    IO.puts "\n # time (s)"
  end

  :io.format "~2B ~.2f~n",
             [
               num_processes,
               time / 1000000.0
             ]
end
########


#### Node ####
iex --sname one
iex --sname two

Node.list
Node.connect(:"one@light-boy")
func = fn -> IO.inspect Node.self end
Node.spawn(:"one@light-boy", func)

iex --sname one --cookie chocolate-chip
Node.get_cookie # => :"chocolate-chip"
########


#### GenServer ####
defmodule Sequence.Server do
  use GenServer

  def init(initial_number) do
    {:ok, initial_number}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  def handle_call({:set_number, new_number}, _from, _current_number) do
    { :reply, new_number, new_number }
  end

  def handle_call({:factors, number}, _, _) do
    { :reply, { :factors_of, number, factors(number)}, [] }
  end
end

# iex -S mix

{:ok, pid} = GenServer.start_link(Sequence.Server, 100) # => {:ok, #PID<0.71.0>}
GenServer.call(pid, :next_number)       # => 100
GenServer.call(pid, :next_number)       # => 101
GenServer.call(pid, {:set_number, 999}) # => 999

{ :ok, pid } = GenServer.start_link(Sequence.Server, 100, name: :seq)
GenServer.call(:seq, :next_number) # => 100
:sys.get_status :seq
# => {:status, #PID<0.69.0>, {:module, :gen_server}, [["$ancestors": [#PID<0.58.0>], "$initial_call": {Sequence.Server, :init, 1}], :running, #PID<0.58.0>, [], [header: 'Status for generic server seq', data: [{'Status', :running}, {'Parent', #PID<0.58.0>}, {'Logged events', []}], data: [{'State', "My current state is '102', and I'm happy"}]]]}
########


#### GenServer Callbacks ####
# init(start_arguments)                   - Called by GenServer when starting a new server
# handle_call(request, from, state)       - Invoked when a client uses GenServer.call(pid, request)
# handle_cast(request, state)             - Called in response to GenServer.cast(pid, request)
# handle_info(info, state)                - Called to handle incoming messages that are not call or cast requests
# terminate(reason, state)                - Called when the server is about to be terminated
# code_change(from_version, state, extra) - OTP lets us replace a running server without stopping the system
# format_status(reason, [pdict, state])   - Used to customize the state display of the server

# call and cast:
# { :noreply, new_state [ , :hibernate | timeout ] }
# { :stop, reason, new_state } # => Signal that the server is to terminate.
# handle_call:
# { :reply, response, new_state [ , :hibernate | timeout ] } # => Send response to the client
# { :stop, reason, reply, new_state } # => Send the response and signal that the server is to terminate
#########


#### Interface ####
defmodule Sequence.Server do
  use GenServer
  #####
  # External API
  def start_link(current_number) do
    GenServer.start_link(__MODULE__, current_number, name: __MODULE__)
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def increment_number(delta) do
    GenServer.cast __MODULE__, {:increment_number, delta}
  end
  #####
  # GenServer implementation
  def init(initial_number) do
    {:ok, initial_number}
  end

  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number+1}
  end

  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end
end
########


#### Supervision ####
# Tree Strategies:
:one_for_one        # If one of the workers dies, then restart it
:one_for_all        # If one dies, supervisor kills the rest and then restart all
:rest_for_one       # If one dies, supervisor kills the rest in start order of these processes and then restart all killed workers
:simple_one_for_one # Same as :one_for_one. But it needs to implement Supervision.Spec and you need to specify only one entry in child specification. That means every child spawned from this supervisor is the same kind of a process.
########


#### Worker Restart Options ####
:permanent # this worker should always be running—it is permanent. This means that the supervision strategy will be applied whenever this worker terminates, for whatever reason.
:temporary # this worker should never be restarted, so the supervision strategy is never applied if this worker dies.
:transient # it is expected that this worker will at some point terminate normally and this terminate should not result in a restart. However, should this worker die abnormally, then it should be restarted by running the supervision strategy.

defmodule Convolver do
  use GenServer, restart: :transient
end
########

#### Server kinds ####
# The Results.    This is the most important server, as it holds the results of the scanning in memory. We need it to be reliable, so we won’t put much code in it.
# The PathFinder. This is responsible for returning the paths to each file in the directory tree, one at a time.
# The Worker.     This asks the PathFinder for a path, calculates the hash of the resulting file’s contents, and passes the result to the gatherer.
# The Gatherer    This is the server that both starts the ball rolling and that determines when things have completed. When they do, it fetches the results and reports on them.
########

#### The Duper Application ####
mix new --sup duper
cd duper
git init
git add .
git commit -a -m 'raw application'

# The Results Server
#duper/1/duper/lib/duper/results.ex
defmodule Duper.Results do
  use GenServer
  @me __MODULE__
  # API
  def start_link(_) do
    GenServer.start_link(__MODULE__, :no_args, name: @me)
  end
  def add_hash_for(path, hash) do
    GenServer.cast(@me, {:add, path, hash})
  end
  def find_duplicates() do
    GenServer.call(@me, :find_duplicates)
  end
  # Server
  def init(:no_args) do
    {:ok, %{}}
  end
  def handle_cast({:add, path, hash}, results) do
    results =
      Map.update(
        results,
        hash,
        [path],
        fn existing ->
          # look in this map
          # for an entry with key
          # if not found, store this value
          # else update with result of this fn
          [path | existing]
        end
      )
    {:noreply, results} end
  def handle_call(:find_duplicates, _from, results) do
    {
      :reply,
      hashes_with_more_than_one_path(results),
      results
    }
  end
  defp hashes_with_more_than_one_path(results) do
    results
    |> Enum.filter(fn {_hash, paths} -> length(paths) > 1 end)
    |> Enum.map(&elem(&1, 1))
  end
end

#duper/1/duper/test/duper/results_test.exs
defmodule Duper.ResultsTest do
  use ExUnit.Case
  alias Duper.Results

  test "can add entries to the results" do
    Results.add_hash_for("path1", 123)
    Results.add_hash_for("path2", 456)
    Results.add_hash_for("path3", 123)
    Results.add_hash_for("path4", 789)
    Results.add_hash_for("path5", 456)
    Results.add_hash_for("path6", 999)
    duplicates = Results.find_duplicates()
    assert length(duplicates) == 2
    assert ~w{path3 path1} in duplicates
    assert ~w{path5 path2} in duplicates
  end
end

# The PathFinder Server
#duper/1/duper/mix.exs
defp deps do
  [
    dir_walker: "~> 0.0.7",
  ]
end

# duper/1/duper/lib/duper/path_finder.ex
defmodule Duper.PathFinder do
  use GenServer
  @me PathFinder
  def start_link(root) do
    GenServer.start_link(__MODULE__, root, name: @me)
  end
  def next_path() do
    GenServer.call(@me, :next_path)
  end
  def init(path) do
    DirWalker.start_link(path)
  end
  def handle_call(:next_path, _from, dir_walker) do
    path = case DirWalker.next(dir_walker) do
      [path] -> path
      other -> other
    end
    {:reply, path, dir_walker} end
end

########


#### Agent ####
# Agents are a simple abstraction around state.
{:ok, count} = Agent.start(fn -> 0 end) # => { :ok, #PID<0.69.0>}
Agent.get(count, &(&1))                 # => 0
Agent.update(count, &(&1 + 1))          # => :ok
Agent.get(count, &(&1))                 # => :1
########


#### Behaviors ####
# Behaviours in Elixir (and Erlang) are a way to separate and abstract the generic
# part of a component (which becomes the behaviour module) from the specific part
# (which becomes the callback module).
########

#### Protocol ####
########

# <- book
