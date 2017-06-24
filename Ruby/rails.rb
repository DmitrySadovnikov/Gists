### jsonb ###

# json_data     - json
# state_history - array in json
# -1            - last element
# max_limit     - elem in json
Order.select("id, json_data #> '{state_history, -1}' -> 'changed_at' as foo").map { |o| "#{o.id} #{o.foo}" }
Order.where("json_data #> '{state_history, 0}' ->> 'from_state' = 's_assessing' ")
Order.where("json_data ->> 'max_limit' LIKE ?", '10_000')

###############

### block ###

3.times { print 'Ho! ' }

def wrap &b
  print 'Santa says: '
  3.times(&b)
end

wrap { print 'Ho! ' }

###############

### validations ###

validates :img_url, allow_blank: true, format: {
  with:    %r{\.(gif\jpg\png)\Z}i,
  message: 'error message'
}

###############

### test ###

# /test/fixtures/products.yml
ruby :
  title : Ruby 2.1 .1
description :
  Ruby is a lang ...

              class ProductTest < ActiveSupport::TestCase
                fixtures :protucts
                #...
              end

###############

### js ###

# controller
if @line_item.save
  format.html { redirect_to strore_index_url }
  format.js { @current_item = @line_item }
  format.json { render :show, status: :created, location: @line_item }
else
end
# create.js.erb
$ ('#cart').html("<%=j render(@cart) %>");
$ ('#current_item').css({ 'background' : 'black' }).animate({ 'backgound' : 'green' }, 1000)

###############

### queries ###

name = params[:name]
pos  = Order.where(["name = ? and pay_type = 'po'", name])

name     = params[:name]
pat_type = params[:pay_type]
pos      = Order.where("name = :name and pay_type = :pay_type", name: name, pay_type: pay_type)
pos      = Order.where("name = :name and pay_type = :pay_type", params[:order])
pos      = Order.where(params[:order])
pos      = Order.where(name: params[:name], pat_type: params[:pay_type])


User.where("name like '?%'", params[:name])
User.where("name like ?", params[:name] + "%")

Order.find_by_sql('select * from orders where id = 3000')

o.attrubutes
o.attrubute_names
o.attribute_present?(:phone)

o.update_all('amount = 3 * amount')
o.transaction { o.title = 'df'; o.inn = '111222444333' }

#### methods ###
class Klass
  undef_method :hash # raise exception if method call

  # @@headers = {}
  cattr_accessor :headers do
    {}
  end
end

module Config
  mattr_accessor :hostname

  def self.hostname
    @@hostname
  end
end
###############

### multitasking ###

Thread.new { loop { count += 1 } }

###############

###### routes ######

concern : :reviewable do
rosources :reviews
member do
  get :xxx
end
end
resources :order, concern :reviewable
resources :users, concern :reviewable

rosources :products, shallow: true do
  resources :reviews
end
# /products/1
# /products/1/reviews => product_reviews_index_path(1)
# /reviews/2
####################

### controller ###

class UsersControler <
  ...
    respond_to :html, :json

  def create
    @user        = User.new(params)
    flash.notice = 'created' if user.save
    respond_with(@user)
  end

  # old spell
  def create
    @user        = User.new(params)
    flash.notice = 'created'

    respond_to |format| do
    format.html
    format.json { render json: @user }
  end
  end

end

####################

Timecop.travel(Date.new(2017, 03, 19)) { Billing::FF2::API::GetLoanState.call(loan) } #отматывает время

####################


rails new myapp --database=postgresql
rails new -h appname #extra options
cd appname
git init
git add.
  git commit -m "Initial commit"
rails s (or rails server) #start server
bundle install
sudo gem install httparty #restful web services client and
#automatic parsing of JSON and XML intu Ruby hashes

/bin/ bash --login #command to switch ruby version


###########
#if Could not find in any of the sources
bundle update

bundle update rake

bundle install --path vendor/cache

delete gemfile.lock

#ActiveRecord::StatementInvalid: PG::UndefinedTable: ERROR:  relation "products" does not exist
delete Entity from routes.rb
###########


##############################

#form helpers for erb
##############################
f.label :title, "Heading"
f.text_field :title, placeholder: "Have a great title?"
f.text_area :content, size: "10x3" #columns X rows
f.date_select
search_field
telephone_field
url_field
email_field
number_field
range_field

f.submit


##############################


##API example parser
##############################
require 'httparty'
require 'pp'

class Coursera
  include HTTParty

  #https://api.coursera.org/api/catalog.v1/courses?fields=smallicon,shortDescription&q=search&query=ruby
  base_uri 'https://api.coursera.org/api/catalog.v1/courses'
  default_params fields: "smallicon,shortDescription", q: "search"
  format :json

  def self.for term
    get("", query: { query: term })["elements"]
  end
end
pp Coursera.for "python"
##############################

#blackbox testing
##############################
#GEmfile:
gem 'capybara', '2.7.0'
gem 'rspec', '3.5.0.beta3'
gem 'selenium-webdriver'
gem 'poltergeist', :git => 'git://github.com/jonleighton/poltergeist.git'
#cmd:
rspec --format documentation

##############################

#root start page rout.rb 
##########
get 'recipes/index'
root :to => 'recipes#index'
##########


#create new scaffold
rails g scaffold car make color: text year : integer #it'll create model, db, view
#OR
rails g model car make model #it will create just a model class and db migration


#Reminder: Ruby/Rails conventions are that class names are CamelCase and file and method names are snake_case.
rails g model super_person first_name: string last_name : string # = SuperPerson

rails destroy model car

rails db: migrate

#add new column to table
rails g migration add_price_to_cars 'price:decimal{10.2}' # It will automatically add column 'price' to cars table

rails g migration add_color_to_cars color: string
rails g migration add_login_pass_to_people login pass


rails g migration rename_make_to_company # it will rename column make to company

rspec -e rq03 .1 #where rq03 - name of context, .1 - name of sub context

#################################


#Rails Console
#################################
rails c
Car.column_names
Car.primary_key


helper.content_tag :p, "Hello" #we can check how our code will render
#=> "<p>Hello</p>" 


#################################


#authentification
#################################
class CreateReviewers < ActiveRecord::Migration[5.0]
  def change
    create_table :reviewers do |t|
      t.string :name
      t.string :password_digest

      t.timestamps
    end
  end
end

class Reviewer < ApplicationRecord
  has_secure_password
end

reviewers = Reviewer.create! name: "Joe", password: "abc123"

joe = Reviewer.find(3) # check user correct of password
puts joe.authenticate("abc124") # return false or User
#################################


#Associations
###################################

#one-to-one
##########
rails g model person first_name last_name
rails g model personal_info height: float weight : float person: references

class Profile < ActiveRecord::Base
  has_one :personal_info, dependent: destroy
end
class PersonalInfo < ActiveRecord::Base
  belongs_to :person
end

#then write to seeds.rb
bill               = Person.find_by first_name: "Bill" #id = 13
pi1                = PersonalInfo.create height: 6.5, weight: 220 #person id automatically = 1 and we will change it
bill.personal_info = pi1 #person id = 13
#its shortly
josh               = Person.find_by firsty_name: "Josh", josh.create_personal_info height: 5.5, weight: 135
##########


#one_to_many
##########
rails g model person first_name last_name
rails g model job company title position_id person: references

class Job < ActiveRecord::Base
  belongs_to :person
end
class Profile < ActiveRecord::Base
  has_many :job
  #or
  has_many :my_jobs, class_name: "Job"
end
Job.create company: "MS", title: "Developer", position_id: "#1234"
p1= Person.first
p1.jobs # its = null
p1.jobs << Job.first #set to person first job from the table
Job.first.person #check it
person.jobs.clear # disassociate jobs from this person FK=null

#create two jobs for the last person
Person.last.create! [
                      { title: "Sr. Developer", company: "MS", position_id: "#5234" },
                      { title: "Sr. Developer", company: "MS", position_id: "#5235" }
                    ]
#count number of jobs for last person
Person.last.jobs.where(company: "MS").count
# => 2
Person.last.jobs.where(company: "MS").to_a #write to array
##########


#many_to_many
##########
rails g model person first_name last_name
rails g model hobby name
#hobbie alphabetically earlier than people!
rails g migration create_hobbies_people person: references hobby : references #its a third table

class CreateHobbiesPeople < ActiveRecord::Migration
  def change
    create_table :hobbies_people, id: false do |t| #SET ID FALSE!!
      t.references :person, index: true, foreign_key: true
      t.references :hobby, index: true, foreign_key: true
    end
  end
end

#or

class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :actor, index: true
    end
  end
end


class Person < ActiveRecord::Base
  has_and_belongs_to_many :hobbies
end
class Hobby < ActiveRecord::Base
  has_and_belongs_to_many :people
end

josh   = Person.find_by first_name: "Josh"
lebron = Person.find_by first_name: "LeBron"

programming = Hobby.create name: "Programming"
josh.hobbies << programming; lebron.hobbies << programming
programming.people #select people with hobby = programming
##########

class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :gender
      t.integer :birth_year
      t.string :first_name
      t.string :last_name
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end


##########


#rich many_to_many
##########

rails g model salary_range min_salary: float max_salary : float job: references

class Job < ActiveRecord::Base
  belongs_to :person
  has_one :salary_range
end
class SalaryRange < ActiveRecord::Base
  belongs_to :job
end
class Person < ActiveRecord::Base
  has_one :personal_info, dependent: :destroy
  has_many :job
  has_many :my_jobs, class_name: "Job"

  has_and_belongs_to_many :hobbies
  has_many :approx_salaries, through: :job, source: :salary_range

  def max_salary
    approx_salaries.maximum(:max_salary)
    #maximum
    #minimum
    #average
    #sum
  end
end


lebron = Person.find_by(first_name: "LeBron")
Hash[lebron.attributes.map { |k, v| [k.to_sym, v] }] # db table to hash


lebron.jobs.count # => 2
lebron.jobs.pluck(:id) # => [12, 13]
Job.find(12).create_salary_range(min_salary: 10000.00, max_salary: 20000.00)
Job.find(13).create_salary_range(min_salary: 15000.00, max_salary: 35000.00)
# we will see lebron's salary 
lebron.approx_salaries #rails c
lebron.approx_salaries.inspect #seeds.rb
#lebron has two jobs than i need loop 
lebron.approx_salaries.each { |x| puts Hash[x.attributes.map { |k, v| [k.to_sym, v] }] }


lebron = Person.find_by last_name: "James"
lebron.max_salary # call method max_salary from model class

##########


#scope
###################################
##########
class Hobby < ActiveRecord::Base
  has_and_belongs_to_many :people

  default_scope { order :name }
end

Hobby.pluck :name # => ["Music", "Programming"]
Hobby.unscoped.pluck :name # => ["Programming", "Music"]
##########
class Person < ActiveRecord::Base
  scope :ordered_by_age, -> { order age: :desc } #create a scope method
  scope :starts_with, -> (starting_string) { where("first_name LIKE ?", "#{starting_string}%") }
end

Peson.ordered_by_age.pluck :age # => [75, 65, 42]
Peson.ordered_by_age.starts_with("Jo").pluck :age : first_name # => [[75, "John"], [65, "Josh"]]
##########

#validations
##########
class Job < ActiveRecord::Base
  #it means that if you dont put this fields to db it cose error
  #for example while registration you need write username, password
  validates :title, :company, presence: true
end

job.errors
job.errors.full_messages #=> ["Title cant be blank", "company cant be blank"]
##########
:numerically
:length
:format
:inclusion # it means if i need number 4 in 3...7 -> true
:exclusion # it means if i need number 99 in 3...7 -> true
##########
#write your own validation
errors.add(columnane, error)
#example:
class SalaryRange < ActiveRecord::Base
  validate :min_is_less_than_max

  def min_is_less_than_max
    if min_salary > max_salary
      errors.add(:min_salary, "cannot be greater than maximum salary!")
    end
  end
end
SalaryRange.create min_salary: 300, max_salary: 100 #=> error
###################################

#n+1 queris and db transactions
###################################
person.all.each { |p| puts p.personal_info.weight } #its bad!
person.includes(:personal_info).all.each { |p| puts p.personal_info.weight } #its good!
###################################


## Rails tests
###################################

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "should not save article without title" do
    article = Article.new
    assert_not article.save
  end

  assert_raises(NameError) do
    some_undefined_variable
  end
end
###################################

#seeds
###################################

User.destroy_all
#Profile.destroy_all
#TodoList.destroy_all
#TodoItem.destroy_all

due_date = Date.today + 1.year

Profile.create! [
                  { first_name: "Carly", last_name: "Fiorina", birth_year: 1954, gender: "female" },
                  { first_name: "Donald", last_name: "Trump", birth_year: 1946, gender: "male" },
                  { first_name: "Ben", last_name: "Carson", birth_year: 1951, gender: "male" },
                  { first_name: "Hillary", last_name: "Clinton", birth_year: 1947, gender: "female" }
                ]

profiles = Profile.all

profiles.each do |profile|
  profile.create_user(username: profile.last_name, password_digest: profile.birth_year)
  profile.user.todo_lists.create!(list_name: profile.first_name, list_due_date: due_date)
end

todolists = TodoList.all

todolists.each do |list|
  5.times do
    list.todo_items.create!(due_date: due_date, title: "Title", description: "Description")
  end
end


a1 = Actor.create(first_name: "George", last_name: "Clooney")
a2 = Actor.create(first_name: "Matt", last_name: "Damon")
a3 = Actor.create(first_name: "Brad", last_name: "Pitt")

m1 = Movie.create(title: "Ocean's 11")
m2 = Movie.create(title: "The Perfect Storm")
m3 = Movie.create(title: "Contagion")

m1.actors << [a1, a2, a3, a4, a5]
m2.actors << [a1, a6, a25]
m3.actors << [a7, a8, a9, a10, a11, a12, a4, a2]

###################################


##CRUD
##############################
Person.column_names
###create
###
val = [
  { user_id: 1, word_id: 10, learned: false },
  { user_id: 2, word_id: 3, learned: true },
  { user_id: 2, word_id: 7, learned: true },
  { user_id: 1, word_id: 9, learned: true }
]
UsersWords.create! val
###

Person.where("age BETWEEN 30 and 33").to_a
Person.where("age BETWEEN ? AND ?", 28, 34).to_a
Person.where("age BETWEEN :min_age AND :max_age", min_age: 28, max_age: 32).to_a
Person.where("first_name LIKE ? OR last_name LIKE ?", '%J%', '%J%').to_a
Person.where("first_name LIKE :pattern OR last_name LIKE :pattern", pattern: '%J%').to_a
Person.where("first_name LIKE '%man'")
###
##UPDATE
Person.find_by(last_name: "Smith").update(last_name: "Smithson") #update one person
Person.find_by(last_name: "Smith").update_all(last_name: "Smithson") #update all person
TodoList.find(id).update(list_name: name)
###
##DELETE
Person.destroy(1) #removes a particular instance from the db
Person.destroy
Person.delete(1) #removes the row from db
Person.delete_all(1)
###

##############################

#cache
##############################
#config/environtment/developments
config.action_controller.perform.caching = true

#to erb
#####
cache do
  ...
end
####
cache @person do
  ...
end
###
cache cache_key_for_people do
  ...
end

#to PeopleHelper
def cache_key_for_people
  count         = Person.count
  max_update_at = Person.maximum(:updated_at).try(:utc).try(:to_s, :number)
  "people/all-#{count}-#{max_updated_at}"
end

###
##############################

--quiet / --silent # wil be empty log 

<<EOF EOF # like quotes
