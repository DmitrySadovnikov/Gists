mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
mix phoenix.new hello_phoenix

mix_path = /Users/sadovnikov/.asdf/installs/elixir/1.4.5/bin/mix

mix ecto.create # create database
mix phoenix.server

mix deps.get # install libruaries

iex -S mix # phoenix console

# debug
require IEx
IEx.pry


# get all instances
MyApp.Repo.all(MyApp.Model)
MyApp.Repo.one(from x in MyApp.Model, order_by: [desc: x.id], limit: 1)
