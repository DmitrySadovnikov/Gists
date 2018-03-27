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


## Types
## Atom
:fred​  ​:is_binary?​  ​:var@2​  ​:<>​  ​:===​  ​:"func/3"​, :"long john silver"​
##

## Range
1..5
##

## Regexp
~r{regexp}
~r/…/

Regex.run ​~​r{[aeiou]}, ​"​​caterpillar"​          # => ["a"]                                    ​ 
Regex.scan ​~​r{[aeiou]}, ​"​​caterpillar"​         # => [["a"], ["e"], ["i"], ["a"]]                                                                                                        ​ 
Regex.split ​~​r{[aeiou]}, ​"​​caterpillar"​        # => ["c", "t", "rp", "ll", "r"]
Regex.replace ​~​r{[aeiou]}, ​"​​caterpillar"​, ​"​​*"​ # => "c​*​t​*​rp​*​ll​*​r
##


####

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
