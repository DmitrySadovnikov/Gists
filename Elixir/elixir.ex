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

////////////////
IO.puts String.upcase("Elixir")

//or//

"Elixir"
|> String.upcase
|> IO.puts
////////////////


/////////////////
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
////////////////////////

//Pattern Matching//
  language = "Elixir"
  IO.puts last_name

  "Jose " <> last_name = "Jose Valim"
  IO.puts last_name

  data = ['Elixir', 'Jose']
  [a, b] = data

  IO.puts "#{a}, #{b}" //Elixir, Jose



defmodule Account do
  def run_transaction(balance, amount, type) do
    if type == :deposit do
      balance + amount
    else
      balance - amount
  end
end

Account.run_transaction(1000, 50, :deposit) //1050
Account.run_transaction(1000, 30, :withdrawl) //1020

//or//
defmodule Account do
  def run_transaction(balance, amount, :deposit) do
    balance + amount
  end

  def run_transaction(balance, amount, :withdrawl) do
    balance + amount
  end
end

////////////////////