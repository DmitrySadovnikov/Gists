mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
mix phoenix.new hello_phoenix

# umbrella app
mix new rsvp_umbrella --umbrella
cd rsvp_umbrella
mix new rsvp --sup
##


# ecto
# migrations
mix ecto.gen.migration add_events_table
# insert
Rsvp.Repo.insert %Rsvp.Events{title: "Codefest", location: "The Office", date: Ecto.DateTime.cast!("2016-11-25 12:00:00")}
# seeds
mix run apps/rsvp/priv/repo/seed.exs
#

mix_path = /Users/sadovnikov/.asdf/installs/elixir/1.4.5/bin/mix

mix ecto.create # create database
mix phoenix.server

mix deps.get # install libruaries

iex -S mix # phoenix console
iex -S mix test /Users/d.sadovnikov/Desktop/repo/../some_test.exs

# debug
require IEx; IEx.pry

# get all instances
MyApp.Repo.all(MyApp.Model)
MyApp.Repo.get(MyApp.Model, 1)
MyApp.Repo.one(
  from x in MyApp.Model,
  where: x.age > ^age,
  order_by: [
    desc: x.id
  ],
  limit: 1
)

# json
model = MyApp.Repo.get(MyApp.Model, "9a3db29a-1234-4a91-1234-e4b89d133554")
%{data: %{"acc_ama" => amount, "acc_curr" => currency}} = model
amount   # => 3000
currency # => RUR
#

# find genserver pid
Process.whereis(:tweet_server) #PID<0.263.0>

# delete process
Process.whereis(:tweet_server) |> Process.exit(:kill)

# run supervisions
mix run --no-halt

# run test with tags
@tag watching: true
mix test --exlude watching
mix test --only watching

