describe Class do
  let(...) { }

  describe '#method' do
    let(...) { }

    include_examples 'universal success case tests'

    it 'works good in default context'

    context 'in situation 1' do
      let(...) { }

      include_examples 'universal success case tests'

      it 'still works good'
    end

    context 'in situation 2' do
      include_context 'for situations 2 and 3'

      let(...) { }

      include_examples 'universal success case tests'

      it 'still works good'
    end

    context 'in situation 3' do
      include_context 'for situations 2 and 3'

      let(...) { }

      it 'fails'
    end
  end
end

result = @ledger.record({ 'some' => 'data' })
result.success? # => a Boolean
result.expense_id # => a number
result.error_message # => a string or nil

require_relative '../../../app/api'
require 'rack/test'
module ExpenseTracker
  RecordResult = Struct.new(:success?, :expense_id, :error_message)
  RSpec.describe API do
    include Rack::Test::Methods
    let(:ledger) { instance_double('ExpenseTracker::Ledger') }
    let(:app) { API.new(ledger: ledger) }

    describe 'POST /expenses' do
      context 'when the expense is successfully recorded' do
        it 'responds with a 200 (OK)' do
          expense = { 'some' => 'data' }
          allow(ledger).to receive(:record)
                             .with(expense)
                             .and_return(RecordResult.new(true, 417, nil))
          post '/expenses', JSON.generate(expense)
          expect(last_response.status).to eq(200)
        end
      end
      context 'when the expense fails validation' do
        # ... specs go here ...
      end
    end
  end
end

context 'with a valid expense' do
  it 'successfully saves the expense in the DB' do
    result = ledger.record(expense)
    expect(result).to be_success
    expect(DB[:expenses].all).to match [
                                         a_hash_including(
                                           id:     result.expense_id,
                                           payee:  'Starbucks',
                                           amount: 5.75,
                                           date:   Date.iso8601('2014-10-17')
                                         )
                                       ]
  end
end

RSpec.describe 'Deprecations' do
  specify 'MyGem.config is deprecated in favor of MyGem.configure'
  specify 'MyGem.run is deprecated in favor of MyGem.start'
end

before(:each) do
  WebBrowser.launch
end

after(:all) do
  WebBrowser.shutdown
end

after(:context) do
  WebBrowser.shutdown
end


RSpec.describe BerlinTransitTicket do
  def fare_for(starting_station, ending_station)
    ticket                  = BerlinTransitTicket.new
    ticket.starting_station = starting_station
    ticket.ending_station   = ending_station
    ticket.fare
  end

  context 'when starting in zone A and ending in zone B' do
    it 'costs €2.70' do
      expect(fare_for('Bundestag', 'Leopoldplatz')).to eq 2.7
    end
  end

  context 'when starting in zone A and ending in zone C' do
    it 'costs €3.30' do
      expect(fare_for('Bundestag', 'Birkenwerder')).to eq 3.3
    end
  end
end


### sahred context ###

RSpec.shared_context 'API helpers' do
  include Rack::Test::Methods

  def app
    ExpenseTracker::API.new
  end

  before do
    basic_authorize 'test_user', 'test_password'
  end
end

RSpec.describe 'Expense Tracker API', :db do
  include_context 'API helpers'
end
#or
RSpec.configure do |config|
  config.include_context 'API helpers'
end


#spec/support/kv_store_shared_examples.rb
RSpec.shared_examples 'KV store' do |kv_store_class|
  let(:kv_store) { kv_store_class.new }

  it 'allows you to get previously stored values' do
    kv_store.store(:language, 'Ruby')
    kv_store.store(:os, 'linux')
    expect(kv_store.fetch(:language)).to eq 'Ruby'
    expect(kv_store.fetch(:os)).to eq 'linux'
  end

  it 'raises a KeyError when you fetch an unknown key' do
    expect { kv_store.fetch(:foo) }.to raise_error(KeyError)
  end
end

require 'hash_kv_store'
require 'support/kv_store_shared_examples'
RSpec.describe HashKVStore do
  it_behaves_like 'KV store', HashKVStore
end

######

##metadata##
RSpec.describe Hash do
  it 'is used by RSpec for metadata' do |example|
    pp example.metadata
  end
end

RSpec.describe Hash do
  it 'is used by RSpec for metadata', :fast, :focus do |example|
    expect(example.metadata).to include(fast: true, focus: true)
  end
end
######

#examples
#######
ratio = 22 / 7.0
expect(ratio).to be_within(0.1).of(Math::PI)
##
numbers = [13, 3, 99]
expect(numbers).to all be_odd
##
alphabet = ('a'..'z').to_a
expect(alphabet).to start_with('a').and end_with('z')
##
expect(['a', 'z']).to start_with_a_and_and_with_z
##
letter_ranges = ['N to Z', 'A to M']
expect(letter_ranges).to contain_exactly(
                           a_string_starting_with('A') & ending_with('M'),
                           a_string_starting_with('N') & ending_with('Z'),
                         )
expect(0).to be_truthy
expect(nil).to be_falsey
##
expect(1).to be < 2
expect(/foo/) =~ 'food'
expect('a string').to match('str')
##
children = [
  { name: 'Coen', age: 4 },
  { name: 'Liza', age: 3 }
]
expect(children).to math [
                           { name: 'Coen', age: a_value > 3 },
                           { name: 'Liza', age: a_value < 3 }
                         ]
expect(children).to contain_exactly(
                      { name: 'Coen', age: a_value > 3 },
                      { name: 'Liza', age: a_value < 3 }
                    )
##
array = [1, 2, 3]
expect { array << 4 }.to change { array.size }
expect { array << 4 }.to change(array, :size)
expect { array << 4 }.to change { array.size }.from(3)
expect { array << 4 }.to change { array.size }.to(5)
expect { array << 4 }.to change { array.size }.from(3).to(5)
expect { array << 4 }.to change { array.size }.to(5).from(3)

x=5
expect { x += 10 }.to change { x }
                        .from(a_value_between(2, 7))
                        .to(a_value_between(12, 17))
expect {}.not_to cahnge { x }.from(5)
##
expect { print 'OK' }.to output('OK').to_stout
expect { warn 'problem' }.to output(/prob/).to_sterr
##
expect('string').to(
  start_with_something_besides('a').and \
    end_with_something_besides('z')
)
expect('string').to(
  start_with_something_besides('a').or \
    end_with_something_besides('z')
)

#######


# doubles
#######
require_relative '../../../app/api'
Rspec.describe API do
  let(:ledger) { instance_double('ExpenseTracker::Ledger') }
  let(:app) { API.new(ledger: ledger) }

  describe 'POST /expenses' do
    context 'hj' do
      it 'sdaf' do
        allow(ledger).to receive(:record)
                           .with(expense)
                           .end_return(RecordResult.new(true, 1, 2))
      end
    end
  end
end

##
yosi = double('Yosi').as_null_object
yosi.eat(:apple)
yosi.eat(:apple).then_shoot(:shell).then_stomp
##
mario = double('Mario')
expect(mario).to receive(:jump)
##
mario = double('Mario').as_null_object
Game.play(mario)
# => nil
expect(mario).to have_received(:jump)
##
mario = spy('Mario')
Game.play(mario)
# <Double 'Mario'>
expect(mario).to have_received(:jump)
#######

# satisfaction
expect(1).to satisfy { |number| number.odd? }

##
expect([1, 2]).to include(*[1, 2])

x = 5
expect { x += 10 }.to change { x }.from(a_value_between(2, 7)).to(a_value_between(12, 17))

# yield_control
expect { |block_checker| just_yield(&block_checker) }.to yield_control
expect { |block| 2.times(&block) }.to yield_control.at_most(4).times

# yield_with_args and yield_with_no_args
def self.just_yield_these(*args)
  yield(args)
end
expect { |block| just_yield_these(1, 'food', Math::PI, &block) }.to yield_with_args(1, /foo/, a_value_within(0.1).of(3.14))
