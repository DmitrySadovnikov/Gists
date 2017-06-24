

## Rails tests
###################################

require 'minitest/autorun'

class Calculator
  attr_reader :digits

  def initialize(digits_string)
    @digits = parse_input(digits_string)
  end

  def sum
    digits.inject(:+)
  end

  def multiply
    digits.inject(:*)
  end

  private

  def parse_input(str)
    str.split(',').map { |n| n.to_i }
  end
end

describe Calculator do
  it 'sums provided digits' do
    calc = Calculator.new('1,2,3,4,5')
    calc.sum.must_equal(15)
  end

  it 'multiplies provided digits' do
    calc = Calculator.new('4,5')
    calc.multiply.must_equal(20)
  end
end

###################################





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


##Unit testing
###################################
# setup() teardown() methods for setting up behavior before and after every test method

#calculator_test.rb

require 'test/unit'
require_relative 'calculator'

class CaculatorTest < Test::Unit::TestCase
  def setup
    @calc = Caculator.new('test')
  end

  #тестируем суммирование
  def test_additional
    #я ожидаю ответ 4 если выполняется код
    assert_equal 4, @calc.add(2,2)
  end

  #тестируем вычитание
  def test_substractions
    assert_equal 2, @calc.substract(4,2)
  end

  def test_devide_by_zero
    #я ожидаю ошибку ZeroDivisionError если выполняется код
    assert_raise ZeroDivisionError do
      @calc.divide(1, 0)
    end
  end
end
###################################

##rspec
###################################
#1 to Gemfile
group :test do
  gem 'rspec-rails', '~> 3.0'
end

#bundler
#rspec --init  #its create "specs" directory

#2
rails generate rspec:install
bundle exec spring binstub --all
#3 to .rspec file
#Add the following line to .rspec to add verbose output to test results.
--format documentation 

rspec #to run all tests
rspec -f d #do show discribtion of tests
rspec -e rq03.1  #where rq03 - name of context, .1 - name of sub context
###

# before() after() methods for setting up behavior before and after every test method
:each :all #to specify before/after each test OR before/after all tests
before :all

##########
#calculator_spec.rb
require 'rspec'
require_relative '../calculator'

describe CaculatorTest do
  before {@calculator = calculator.new('RSpec calculator')}


  context "rq01" do
    it "should add 2 numbers correctly" do
      expect(@calculator.add(2,2)).to eq 4
    end

    it "should substract 2 numbers correctly" do
      expect(@calculator.substract(4,2)).to eq 2
    end
  end

  context "rq02" do
    it "should sum two odd numbers and become even" do
      expect(@calculator.add(3,3)).to be_even
      expect(@calculator.add(3,3)).not_to be_odd
      expect(@calculator.add(3,3)).not_to be_nil
    end
  end

  context "rq03" do
    it "MedicalRecord has a 1:1 linked uni-directional relationship to Racer" do
      expect(MedicalRecord).to belong_to(:racer).of_type(Racer)    
    end

    before :all do
      MedicalRecord.delete_all
      Racer.delete_all
      @racer = Racer.create(:fn=>"cat", :ln=>"inhat", :dob=>Date.new(2000, 11, 12))
    end


    around :each do |example|
      if $continue
        $continue = false 
        example.run 
        $continue = true unless example.exception
      else
        example.skip
    end

  end

end

##########

require_relative '../lib/playground'

describe Playground do
  context 'when there are no children' do
    let(:playground) { Playground.new(0) } #создаю переменную playground для каждого теста

    it 'is quite boring place' do
      mood = playground.mood
      expect(mood).to eq('boring')
    end

    it 'is empty' do
      expect(playground).to be_empty
    end
  end
end

##########
require_relative '../lib/bowling_game'

describe BowlingGame do
  let(:game) { BowlingGame.new }

  it 'scores a gutter game' do
    game.pins([0] * 20)
    expect(game.score).to eq(0)
  end

  it 'scores a game of 1s' do
    game.pins([1] * 20)
    expect(game.score).to eq(20)
  end

  it 'scores a game with spare' do
    game.pins([4,6,5] + [0]*17)
    expect(game.score).to eq(20)
  end

  it 'scores a game with strike' do
    game.pins([10,3,5] + [0]*17)
    expect(game.score).to eq(26)
  end

  it 'scores a perfect game' do
    game.pins([10]*12)
    expect(game.score).to eq(300)
  end
end

##########

# capibara
##########

#spec/features/home_page_spec.rb
require 'rails_helper'

feature 'home page' do
  scenario 'welcome message' do
    visit('/')
    expect(page).to have_content('Welcome')
  end
end


###########

# spec/features/create_achievement_spec.rb
require 'rails_helper'
require_relative '../support/login_form'
require_relative '../support/new_achievement_form'

feature 'create new achievement' do
  let(:login_form){ LoginForm.new}
  let(:new_achievement_form){ NewAchievementForm.new }
  let(:user){FactoryGirl.create(:user)}

  background do
    login_form.visit_page.login_as(user)
  end

  scenario 'create new achievement with valid data' do

    #visit('/')
    #click_on('New Achievment')
    fill_in('Title', with: 'Read a book')
    fill_in('Discription', with: 'RExcellent read')
    select('Public', form: 'Privacy')
    check('Featered achievmrnts')
    atach_file('Cover image', "#{Rails.root}/specficxtures/cover_image.png")


    new_achievement_form.visit_form.fill_in_form({title: 'Read a book'}).submit_form

    expect(page).to have_content("Achievement has been created")
    expect(Achievement.last.title).to eq('Read a book')
  end

  scenario 'cannot create achievement with invalid data' do
    new_achievement_form.visit_form.submit_form

    expect(page).to have_content("can't be blank")
  end
end

#####
describe Zombie do
  it 'is hungry' do
    zombie = Zombie.new
    zombie.hungry?.should == true
  end
end

zombie.hungry?.should be_true
zombie.should be_hungry
#####
zombie.name.should == 'Ash'
zombie.alive.should == false 
zombie.alive.should be_false
zombie.rotting.should == true 
zombie.alive.should be_true

zombie.height.should > 5
zombie.height.should >= 5
zombie.height.should < 5
zombie.height.should_not == 5
zombie.brains.should be < 1
#####
describe Zombie do
  it "has a name that matches 'Ash Clone'" do
    zombie = Zombie.new(name: "Ash Clone 1")
    zombie.name.should match(/Ash Clone \d/)
  end
end
#####
require 'spec_helper'
describe Zombie do
it 'is invalid without a name' do
    zombie = Zombie.new
    zombie.should_not be_valid
  end
end
app/models/zombie.rb
class Zombie < ActiveRecord::Base
  validates :name, presence: true
end
#####

describe Zombie do
  it 'include tweets' do
    tweet1 = Tweet.new(status: 'Uuuuunhhhhh')
    tweet2 = Tweet.new(status: 'Arrrrgggg')
    zombie = Zombie.new(name: 'Ash', tweets: [tweet1, tweet2])
    zombie.tweets.should include(tweet1)
    zombie.tweets.should include(tweet2)
  end
end
#####

describe Zombie do
  it 'starts with two weapons' do
    zombie = Zombie.new(name: 'Ash')
    zombie.weapons.count.should == 2
  end
end

describe Zombie do
  it 'starts with two weapons' do
    zombie = Zombie.new(name: 'Ash')
    zombie.should have(2).weapons
  end
end
#####
describe Zombie do
  it 'changes the number of Zombies' do
    zombie = Zombie.new(name: 'Ash')

    # Zomies amount changed
    expect { zombie.save }.to change { Zombie.count }.by(1)

    # OR
    expect { zombie.save }.to change { Zombie.count }.from(0).to(1)
  end
end
#####

describe Zombie do
  it 'raises an error if saved without a name' do
    zombie = Zombie.new
    expect { zombie.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )

    #OR 
    # to_not not_to
  end
end
#####
# More matchers

@zombie.should respond_to(:hungry?)
@width.should be_within(0.1).of(33.3)
@zombie.should exist
@zombie.should satisfy { |zombie| zombie.hungry? }
@hungry_zombie.should be_kind_of(Zombie) #HungryZombie < Zombie
@status.should be_an_instance_of(String)
#####
# RUN rspec

#run with option --color
$ rspec --color spec/models/zombie_spec.rb

$ rspec --color --format documentation spec/models/zombie_spec.rb

--color
--format documentation

#####
describe Zombie do
  its(:name) { should == 'Ash' }
  its(:weapons) { should include(weapon) }
  its(:brain) { should be_nil }
  its('tweets.size') { should == 2 }
end

#####

describe Zombie do
  context 'when hungry' do
   it 'craves brains'
    context 'with a veggie preference' do
     it 'still craves brains'
     it 'prefers vegan brains'
   end
 end
end

#####
context 'with a veggie preference' do
  let(:zombie){ Zombie.new(vegetarian: true, weapons: [axe]) }
  let(:axe) { Weapon.new(name: 'axe') }
  subject { zombie }
  its(:weapons) { should include(axe) }
  it 'can use its axe' do
    zombie.swing(axe).should == true
end

#####
describe Zombie do
  let ! (:zombie) { Zombie.create } #Will create zombie before every example
  subject { zombie }
  its(:name) { should be_nil? }
end
#####

describe Zombie do
  let(:zombie) { Zombie.new }
  before { zombie.hungry! }

  it 'is hungry' do
    zombie.should be_hungry
  end

  it 'craves brains' do
    zombie.should be_craving_brains
  end
end
#####
describe Zombie do
  it_behaves_like 'the undead', Zombie.new
end

describe Vampire do
  it_behaves_like 'the undead', Vampire.new
end

#create shared spec (spec/support/shared_examples_for_undead)
shared_examples_for 'the undead' do |undead|
  it 'does not have a pulse' do 
    undead.pulse.should == false
  end
end

#####
shared_examples_for 'the brainless' do
  it { should be_dummy }
  it { should_not be_genius }
end

describe Zombie do
  let(:zombie) { Zombie.new }
  subject { zombie }
  it_behaves_like 'the brainless'
end

describe Plant do
  let(:plant) { Plant.new }
  subject { plant }
   it_behaves_like 'the brainless'
end

#####

describe Zombie do
  context 'when hungry' do
    it 'wants brains'
      context 'with a veggie preference', focus: true do #run only this context
        it 'still craves brains'
        it 'prefers vegan brains' , vegan: true
    end
  end
end

# rspec spec/lib/zombie_spec.rb  


describe Zombie do
  context 'when hungry' do
    it 'wants brains'
      context 'with a veggie preference', slow: true do #skip this context
        it 'still craves brains'
        it 'prefers vegan brains' , vegan: true
    end
  end
end

# rspec spec/lib/zombie_spec.rb               


# spec/spec_helper.rb
RSpec.configure do |config|  
  config.filter_run slow: true  # ~ skip this check by default
  config.run_all_when_everything_filtered = true #run severything if none match
end

# rspec --tag ~slow spec/lib/zombie_spec.rb   ~ skip this test
# rspec --tag slow spec/lib/zombie_spec.rb   run this test



#####
#Mocking

describe Zombie do
  let(:zombie) { Zombie.create }

  context "#decapitate" do

    it "calls weapon.slice" do
      zombie.weapon.should_receive(:slice)
      zombie.decapitate
    end

    it "set status to dead again" do
      zombie.weapon.stub(:slice)
      zombie.decapitate
      zombie.status.should == "dead again"
    end
  end
end

#####

class Zombie < ActiveRecord::Base
 def geolocate 
   Zoogle.graveyard_locator(self.graveyard)
 end
end


it "calls Zoogle.graveyard_locator" do
  Zoogle.should_receive(:graveyard_locator).with(zombie.graveyard)
  zombie.geolocate
end
#####

# mock with returning parameters


 def geolocate 
   Zoogle.graveyard_locator(self.graveyard)
 "#{loc[:latitude]}, #{loc[:longitude]}"
 end

it "calls Zoogle.graveyard_locator" do
  Zoogle.should_receive(:graveyard_locator).with(zombie.graveyard)
  .and_return({latitude: 2, longitude: 3})
  zombie.geolocate
end

####

def geolocate_with_object
  loc = Zoogle.graveyard_locator(self.graveyard)
  "#{loc.latitude}, #{loc.longitude}"
end


it "returns properly formatted lat, long" do
  loc = stub(latitude: 2, longitude: 3)
  Zoogle.stub(:graveyard_locator).returns(loc)
  zombie.geolocate_with_object.should == "2, 3"
end

####

class ZombieMailer < ActionMailer::Base

def welcome(zombie)
  mail(from: 'admin@codeschool.com', to: zombie.email,
  subject: 'Welcome Zombie!')
end

end
describe ZombieMailer do
  context '#welcome' do
    let(:zombie) { stub(email: 'ash@zombiemail.com') }
    subject { ZombieMailer.welcome(zombie) }

    its(:from) { should include('admin@codeschool.com') }
    its(:to) { should include(zombie.email) }
    its(:subject) { should == 'Welcome Zombie!' }
  end
end

####

describe Tweet do
  context 'after create' do
    let(:zombie) { Zombie.create(email: 'anything@example.org') }
    let(:tweet) { zombie.tweets.new(message: 'Arrrrgggghhhh') }
    let(:mail) { stub(:mail, deliver: true) }

    it 'calls "tweet" on the ZombieMailer' do
      ZombieMailer.should_receive(:tweet).with(zombie, tweet).and_return(mail)
      tweet.save
    end

    it 'calls "deliver" on the mail object' do
      ZombieMailer.stub(:tweet).and_return(mail)
      mail.should_receive(:deliver).and_return(true)
      tweet.save
    end
  end
end




####

# должен вызвать метод
target.should_receive(:function).once
                                .twice
                                .exactly(3).times
                                .at_least(2).times
                                .at_most(3).times
                                .any_number_of_times

target.should_receive(:function).with(no_args())
                                .with(any_args())
                                .with("B", anything())
                                .with(3, kind_of(Numeric))
                                .with(/zombie ash/)

####
#matchers
class Zombie < ActiveRecord::Base
  validates :name, presence: true
end

describe Zombie do
  it 'validates presence of name' do
    zombie = Zombie.new(name: nil)
    zombie.should validate_presence_of_name
  end
end
###
# custom matchers
#spec/support/validate_presence_of_name.rb
module ValidatePresenceOf
  class Matcher
    def initialize(attribute)
      @attribute = attribute
    end 

    def matches?(model)
      model.valid?
      model.errors.has_key?(@attribute)
    end

    def validate_presence_of(attribute)
      Matcher.new(attribute)
    end
  end
end


######
module ValidateNumericalityOf
  class Matcher
    def initialize(attribute)
      @attribute = attribute
      @options = {}
      @errors = []
    end

    def matches?(model)
      @model = model
      @model[@attribute] = "not a number"
      @model.valid?

      if !@model.errors[@attribute].include?("is not a number")
        @errors << "numericality" 
      end

      if @options[:only_integers]
        @model[@attribute] = 1.5
        @model.valid?
        if !@model.errors[@attribute].include?("must be an integer")
          @errors << "as an integer"
        end
      end

      @errors.empty?

    end
    
    def only_integers
      @options[:only_integers] = true
      self
    end

    def failure_message
      "#{@model.class} failed to validate: #{@attribute} #{@errors.join(', ')}"
    end

    def negative_failure_message
      "#{@model.class} unexpected validation: #{@attribute} #{@errors.join(', ')}"
    end

    def description
      "validate numericality of #{@attribute}"
    end
  end

  def validate_numericality_of(attribute)
    Matcher.new(attribute)
  end
end

RSpec.configure do |config|
  config.include ValidateNumericalityOf, type: :model
end

######



#other
####
expect(content_block_1).to be_persisted #проверяем если существует объект
####











###################################