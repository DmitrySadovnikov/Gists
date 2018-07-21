mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
mix phoenix.new hello_phoenix

# umbrella app
mix new rsvp_umbrella --umbrella
cd rsvp_umbrella
mix new rsvp --sup
##


########
# alias - allows shorter names
# import - allows easy access to functions from other modules
# use - similar to import but allows to inject code and gives modules authors
########

# ecto
# One-to-one
user = %User{name: "John Doe", email: "john.doe@example.com"}
user = Repo.insert!(user)

avatar = %Avatar{nick_name: "Elixir", pic_url: "http://elixir-lang.org/images/logo.png"}
user = %User{name: "John Doe", email: "john.doe@example.com", avatar: avatar}
user = Repo.insert!(user)
Repo.all(User) |> Repo.preload(:avatar)

# One-to-many
post = Ecto.build_assoc(user, :posts, %{header: "Clickbait header", body: "No real content"})
Repo.insert!(post)

post = Ecto.build_assoc(user, :posts, %{header: "5 ways to improve your Ecto", body: "Add url of this tutorial"})
Repo.insert!(post)

Repo.get(User, user.id) |> Repo.preload(:posts)

# Many-to-many
clickbait_tag = Repo.insert! %Tag{name: "clickbait"}
misc_tag = Repo.insert! %Tag{name: "misc"}
ecto_tag = Repo.insert! %Tag{name: "ecto"}
post = %Post{header: "Clickbait header", body: "No real content"}
post = Repo.insert!(post)

post_changeset = Ecto.Changeset.change(post)
post_with_tags = Ecto.Changeset.put_assoc(post_changeset, :tags, [clickbait_tag, misc_tag])
post = Repo.update!(post_with_tags)

post = Repo.get(Post, post.id) |> Repo.preload(:tags)
tag = Repo.get(Tag, 1) |> Repo.preload(:posts)

post_changeset = Ecto.Changeset.change(post)
post_with_tags = Ecto.Changeset.put_assoc(post_changeset, :tags, [misc_tag])

post = Repo.update!(post_with_tags)
##

alias App.Repo
alias App.Tag
alias App.Operation
alias App.OperationQuery
alias App.OperationTag
{:ok, tag} = Repo.insert %Tag{title: "shit"}

Repo.all(Tag)
tag = Repo.one(Tag)
tag = Repo.preload(tag, :operations)

Repo.all(Ecto.Query.from p in Tag, where: is_nil(p.inserted_at))

{:ok, tag}     = Repo.insert %Tag{title: "test"}
{:ok, operation_tag} = Repo.insert %OperationTag{tag_id: tag.id, operation_id: "e10bc018-d3fd-44cc-9de3-4195f8661760"}

operation = OperationQuery.find("946d6c54-f078-4698-87e7-83f57769478d")
operation |> Operation.changeset(%Operation{tags: [tag]})
operation |> Operation.changeset(%Operation{tags: [%Tag{title: "test1"}]})

Changeset.put_assoc(operation, :tags, [tag])

Repo.preload(operation_tag, :tag)

x = App.Tag.changeset(%App.Tag{}, %{title: "shit"})
x.valid?

from(
  user in Client,
  join: party in Party,
  on: party.user_id == user.id,
  where: party.user_id == type(^user_id, UUID),
  where: party.deleted == ^deleted,
  order_by: fragment("? desc nulls last", party.last_operation_date),
  select: %{
    id: user.id,
    status: user.status,
    data: user.data,
    last_operation_date: party.last_operation_date
  }
)
# sandbox
Ecto.Adapters.SQL.Sandbox.mode(Repo, :auto)
Ecto.Adapters.SQL.Sandbox.checkout(App.Repo)
# migrations
mix ecto.gen.migration add_events_table
# insert
Rsvp.Repo.insert %Rsvp.Events{title: "Codefest", location: "The Office", date: Ecto.DateTime.cast!("2016-11-25 12:00:00")}
# seeds
mix run apps/rsvp/priv/repo/seed.exs
#
date = Ecto.DateTime.from_erl({{2016, 1, 1}, {12, 0, 0}})
# view
Phoenix.View.render(RsvpWeb.EventView, "details.html", event: %{title: "My Title", location: "My Town", date: date, description: "Simple Description"})
#{:safe,
#  [
#    [
#      [
#        [[[["" | "<h1>"] | "My Title"] | " <small>"] | "My Town"] |
#        "</small></h1>\n<h3>"
#      ] |
#      "2016/1/1"
#    ] |
#    "</h3>\n"
#  ]}
#
#


# routes helpers
mix phoenix.routes
RsvpWeb.Router.Helpers.event_path(RsvpWeb.Endpoint, :list)    # => /events
RsvpWeb.Router.Helpers.event_path(RsvpWeb.Endpoint, :show, 1) # => /events/1


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

