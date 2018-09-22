###### Indexe
disable_ddl_transaction! # disable transaction around migration

add_index :users,
          :setting_id,
          algorithm: :concurrently # without locking a table for preventing downtime

add_index :users,
          :email,
          name:  'index_on_email',
          using: :btree # index type

add_index :users,
          :data, # json, text, array
          using: :gin

###### Index Types
# B-Tree                                 - creates a tree that will keep itself balanced and even. Default. Accelerates search
# Generalized Inverted Index (GIN)       - for columns with multiple values (hStore, Arrays, Range types, JSONB)
# Generalized Inverted Seach Tree (GiST) - for rows that overlap values (Geometry types, Text when dealing with full-text search)
# Space partitioned GiST (SP-GiST)       - for larger data (when your data has a natural clustering element) eg phone number 7 -> 916 -> 1111111
# Block Range Indexes (BRIN)             - (non tree) for larger data (when there is some natural ordering to the data, and the data tends to be very large), eg similar zip codes of city are located near each other on disk
# Hash                                   - for equality operations, and generally B-Tree still what you want here

###### params
'ids[]'  = 1
'ids[]'  = 2
'q[aaa]' = 123
'q[bbb]' = 345
# got {"q"=>{"aaa"=>"123", "bbb"=>"345"}, "ids"=>["1", "2"]}
# raw ?ids%5B%5D=1&ids%5B%5D=2&q%5Baaa%5D=123&q%5Bbbb%5D=345
###############


# another port
# ifconfig (get ip)
# rails server -e development -b xxx.xxx.xxx.xxx -p 3001

### jsonb ###

# json_data     - json
# state_history - array in json
# -1            - last element
# max_limit     - elem in json
Order.select("id, json_data #> '{state_history, -1}' -> 'changed_at' as foo").map { |o| "#{o.id} #{o.foo}" }
Order.where("json_data #> '{state_history, 0}' ->> 'from_state' = 's_assessing' ")
Order.where("json_data ->> 'max_limit' LIKE ?", '10_000')

# convert to date
Order.where("(data ->> 'date')::date = ?", Date.current)
###############

User.where('name SIMILAR TO ?', '(va|gi|na)%')

###### included
module Yy
  require 'rails'

  module Yy
    extend ActiveSupport::Concern

    included do
      def self.klass_method
        puts 'klass_method'
      end

      def nstns_method
        puts 'nstns_method'
      end
    end
  end

  class Xx
    include Yy
  end

  Xx.new.nstns_method
  Xx.klass_method
end
######

### validations ###

validates :img_url, allow_blank: true, format: {
  with:    %r{\.(gif\jpg\png)\Z}i,
  message: 'error message'
}

###############


# delegate
class User
  has_many :orders

  def some_method
    'go to hell'
  end
end

class Order
  belongs_to :user
  delegate   :some_method, to: :user
end

Order.last.some_method # => 'go to hell'

# override delegate
class Admin
  def some_method
    'go to adminka'
  end
end

class Order
  belongs_to :user
  delegate   :some_method, to: :user

  def user
    Admin.first
  end
end

Order.last.some_method # => 'go to adminka'
###

###
# app/validators/safe_for_work_validator.rb
class SafeForWorkValidator < ActiveModel::EachValidator
  BAD_WORDS = %w(darn gosh heck golly)

  def validate_each(record, attribute, value)
    if BAD_WORDS.any? { |word| value.include?(word) }
      record.errors[attribute] << (options[:message] || 'is not safe for work!')
    end
  end
end

class User < ActiveRecord::Base
  validates :username, safe_for_work: true
end

class Admin < ActiveRecord::Base
  validates :username, safe_for_work: true
end
###


###
User.find_each(batch_size: 100) do |user|
  Newsletter.weekly(user).deliver_now
end
###


## partial
# <%= render partial: "product", collection: @products %>
# or
# <%= render @products %>
###

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
pos      = Order.where('name = :name and pay_type = :pay_type', name: name, pay_type: pay_type)
pos      = Order.where('name = :name and pay_type = :pay_type', params[:order])
pos      = Order.where(params[:order])
pos      = Order.where(name: params[:name], pat_type: params[:pay_type])


User.where("name like '?%'", params[:name])
User.where('name like ?', params[:name] + '%')

Order.find_by_sql('select * from orders where id = 3000')

o.attrubutes
o.attrubute_names
o.attribute_present?(:phone)

o.update_all('amount = 3 * amount')
o.transaction { o.title = 'df'; o.inn = '111222444333' }
###
Restaurant.all.includes([{:reviews => author}, :address])
###

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
concern :reviewable do
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
class UsersControler < ApplicationController
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

    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
end
##########
Timecop.travel(Date.new(2017, 03, 19)) { Loan::GetState.call(loan) } # отматывает время
##########


#form helpers for erb
##############################
f.label :title, 'Heading'
f.text_field :title, placeholder: 'Have a great title?'
f.text_area :content, size: '10x3' #columns X rows
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


#Rails Console
#################################
rails c
Car.column_names
Car.primary_key
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

reviewers = Reviewer.create! name: 'Joe', password: 'abc123'

joe = Reviewer.find(3) # check user correct of password
puts joe.authenticate('abc124') # return false or User
#################################


#Associations
###################################

#one-to-one
##########

# rails g model person first_name last_name
# rails g model personal_info height: float weight: float person: references


class Profile < ActiveRecord::Base
  has_one :personal_info, dependent: :destroy
end

class PersonalInfo < ActiveRecord::Base
  belongs_to :person
end

#then write to seeds.rb
bill = Person.find_by(first_name: 'Bill') # id = 13
pi1  = PersonalInfo.create(height: 6.5, weight: 220) #person id automatically = 1 and we will change it

bill.personal_info = pi1
#its shortly
josh = Person.find_by(firsty_name: 'Josh')
josh.create_personal_info(height: 5.5, weight: 135)
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
Person.last.jobs.where(company: "MS") #write to array
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
scope :scheduler, default: true, &:scheduler
scope :for_user, -> (user_id) { where('user_ids @> ARRAY[:user_id]::integer[]', user_id: user_id) }
##########
class Person < ActiveRecord::Base
  scope :active,         -> { where(state: 'active') }
  scope :ordered_by_age, -> { order(age: :desc) }
  scope :starts_with,    -> (starting_string) { where('first_name LIKE ?',
                                               "#{starting_string}%") }
end

Person.ordered_by_age.pluck(:age) # => [75, 65, 42]
Person.ordered_by_age.starts_with('Jo').pluck(:age, :first_name) # => [[75, "John"], [65, "Josh"]]
Person.active.ordered_by_age
##########
class Role < ActiveRecord::Base
  scope :billable, -> { where(kind: 'billable') }
end

Person.joins(:role).merge(Role.billable)
##########


# concern
module Reviewable
  extend ActiveSupport::Concern

  included do
    has_many :reviews, as: :reviewable, dependent: :destroy
  end

  module ClassMethods
    def with_no_reviews
      where('id NOT IN (SELECT DISTINCT(reviewable_id) FROM reviews WHERE reviewable_type = ?)', self.name)
    end
  end

  def reviews_rating
    (reviews.positive.count / reviews.approved.count.to_f).round(2)
  end
end

##########


# decorator
class ItemDecorator
  def initialize(item)
    @item = item
  end

  def is_featured?
    @item.ratings > 5
  end

  def method_missing(method_name, *args, &block)
    @item.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    @item.respond_to?(method_name, include_private) || super
  end
end
##########



# serializer
class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :reviews
  embed :ids, include: true

  def reviews
    object.reviews.approved
  end
end
##########



# n+1 queries and db transactions
###################################
person.all.each { |p| puts p.personal_info.weight } #its bad!
person.includes(:personal_info).all.each { |p| puts p.personal_info.weight } #its good!
###################################


##CRUD
##############################
Person.column_names
### GET
Person.where(age: 30..33)
Person.where('age BETWEEN 30 and 33')
Person.where('age BETWEEN ? AND ?', 28, 34)
Person.where('age BETWEEN :min_age AND :max_age', min_age: 28, max_age: 32)
Person.where('first_name LIKE ? OR last_name LIKE ?', '%J%', '%J%')
Person.where('first_name LIKE :pattern OR last_name LIKE :pattern', pattern: '%J%')
Person.where("first_name LIKE '%man'")

## UPDATE
Person.find_by(last_name: 'Smith').update(last_name: 'Smithson')   # update one person
Person.where(last_name: 'Smith').update_all(last_name: 'Smithson') # update all person
##DELETE
Person.destroy(1) # removes a particular instance from the db
Person.destroy
Person.delete(1) # removes the row from db
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
end

cache @person do
end

cache cache_key_for_people do
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
