require 'file_name' # includes file
include ModuleName  # includes instance methods
extend  ModuleName  # includes class methods
prepend ModuleName  # includes methods above instance methods

# comment annotation
# TODO:
# FIXME:
# OPTIMIZE:
# HACK:
# REVIEW:
######

#heredoc
ActiveRecord::Base.connection.execute(<<-SQL).first['customer_mail']
SELECT email customer_mail FROM users WHERE admin = 'f' AND id = '#{@user.id}'
SQL
######

######
module_function # turn instance methods to class methods

module SomeModule
  mudule_function

  def some_method; end
end
######


# format
format('one: %s, two: %s', 1, 2) # => "one: 1, two: 2"
######


# float
325.09 * 100 # => 32508.999999999996
######


###
def some_method
  print 'hello'
end

def repeat
  2.times { yield }
end

repeat &method(:some_method) # convert method to proc
# => hellohello
###
def xxx(*)
  super(4, 5, 6)
end
###
def foo(a, *b, **c)
  [a, b, c]
end

foo 10                        # => [10, [], {}]
foo 10, 20, 30                # => [10, [20, 30], {}]
foo 10, 20, 30, d: 40, e: 50  # => [10, [20, 30], {d: 40, e: 50}]
foo 10, d: 40, e: 50          # => [10, [], {d: 40, e: 50}]
###
def x(a:)
  local_variables.each { |v| puts eval "#{v}" }
end
x(a: 10) # => 10
###
def x(*)
  local_variables.each { |v| puts eval "#{v}" }
end
x(10) # => 10
###
/sera/     === 'coursera' # => true
'coursera' === 'coursera' # => true
Integer    === 21         # => true сравнивает объект и класс
(1..5)     === 3          # => true
(1..5)     === 6          # => false
###
[9, 3, 4, 9, 5].count(9)  # => 2
######

##
a =  [:foo] * 4  # => [:foo, :foo, :foo, :foo]
a = *[:foo] * 4  # => :foo, :foo, :foo, :foo   it's split arguments
##
# string to ruby code
eval('[1, 2] << 3') # => [1, 2, 3]

###### examples
private
attr_reader :payments
###
delegate :credit_amount, :credit_term, :base_rate, to: :borrower
###
def human_repayment_frequency
  {
    'week'  => 7,
    'month' => 30
  }[order.repayment_frequency]
end

# inject
######
'ModuleName::KlassName'.split('::').inject(Object) { |par, const| par.const_get(const) } # вернет KlassName
######
(1..3).inject([]) { |arr, n| arr << n}           # => [1, 2, 3]
(1..3).inject({}) { |hsh, n| hsh.merge(n => n) } # => { 1 => 1, 2 => 2, 3 => 3 }
(1..3).inject({}) { |hsh, n| hsh[n] = n; hsh }   # => { 1 => 1, 2 => 2, 3 => 3 }
######
[1, 2, 5].inject(10, &:+) # => 18
######
[1, 2, 3].inject { |res, i| res + i } # => 6
[1, 2, 3].inject(:+) # => 6
[true, false, true].inject(:&) == false
[true, true, true].inject(:&)  == true
######
[1, 2, 3].any? { |x| x == 1 }        # => true
(1..10).all? { |number| number < 8 } # => true
######
set = Set.new [1, 'str1', 'str2', 2, 4]
set.classify { |f| f.class } # => {Fixnum=>#<Set: {1, 2, 4}>, String=>#<Set: {"str1", "str2"}>}
######
h = {a: 1, b: 2, c: 3}
h.each_key { |k| puts h[k] }
######
"aaa\nbbbb".each_line { |x| puts x }
######
%w(aaa bbb ccc add).grep(/^a/) { |el| el } # => ["aaa", "add"]
######
x = proc { |x| x + 1}
x.call(2) # => 3
x.(2)     # => 3
######
(1..20).each { |i| puts i if (i == 3)..(i == 15) }
######
[[1, 2], [3, 4]].each { |(first, second)| p first } # => 1, 3
######
BigDecimal.new('123.45678901234567890').to_s('3F') # "123.456 789 012 345 678 9"
######

## Mimic Method
def BaseClass(name)
  name == 'string' ? String : Object
end

class C < BaseClass 'string'
  attr_accessor :an_attribute
end
######

## Hash
##############################
# tap - принимает на вход себя и изменяет
hash = {
  id:   1,
  name: 'dima',
  age:  26
}
hash.tap { |el| el[:name].capitalize!; el[:sex] = 'male' }
# => {:id=>1, :name=>"Dima", :age=>26, :sex=>"male"}
######
hash = { marko: 'polo' }
hash.fetch(:marko)        # => 'polo'
hash.fetch(:marko, false) # если hash[:marko] == nil, то вернется false
######
[[1, 2], [3, 4]].to_h # => {1=>2, 3=>4}
##############################



# change if something exists
something &&= something.downcase
######
4.next # will return 5
######
obj.respond_to? :some_method # true / false

# methods
puts             # => println and return nil
p                # => println
print            # => print
gets             # => input text
<=>              # comparator
sample(x)        # выводит случайные x элемента массива
is_a?            # => intenceOf
kind_of?         # => intenceOf
chomp            # обрезает \n в конце
select           # => выбирает из массива значения соотв заданным условиям
gsub!(/s/, 'th') # => replace
include?         # => contains
index            # return index of letter in string
lstrip           # удаляет пробелы
start_with?
end_with?

# перенос строки
'this is very' \
'long string'

x = 5 \
    - 4
# => 1
###

'It\'s a hot day outside'.sub! 'hot', 'rainy' # It's a rainy day outside

Time.now - current time
Date.today - current date

my_object.instance_variables # => show all @vars
my_object.instance_methods(false) # => false = without inherited methods
my_object.instance_methods.grep /^re/
Array.superclass
Array.constants.include? :Object

module M
  class C
    module M2
      Module.nesting # => [M::C::M2, M::C, M]

      date = Date.current + 1.year
      date.future?
      'word'.pluralize             # => words
      'words'.singularize          # => word
      'hello_world'.camelize       # => HelloWorld
      'HelloWorld'.underscore      # => hello_world
      'hello_world'.dasherize      # => hello-world
      'hello world'.parameterize   # => hello-world
      'Hello     world    '.squish # => "Hello world"
      'word'.upcase                # => WORD
      'WORD'.downcase              # => word
      'word'.capitalize            # => Word
      'word'.intern                # => :word

      begin
      rescue SomeExceptionClass => some_variable
      rescue SomeOtherException => some_other_variable
      else
      ensure
        # код выполняется всегда
      end
    end
  end
end
##############################

##variables
##############################
alpa, _indent, some_var           # local var
self, nil, FILE                   # pseudo var
K6chip, length, LENGTH, ALL_CAPS  # constants
@foobar, @thx1138, @NOT_CONST     # var of exemplar
@@phydeaux, @@my_var, @@NOT_CONST # var of class
$beta, $B12vitamin, $NOT_CONST    # global var
CamelCase                         # class name

Fixnum # (целые числа, меньшие 2^{ 30 }),
Bignum # (целые числа, большие 2^{ 30 }),
Float
Array
String
Hash
##############################

##increment
##############################
#succ and next are equals
'abcd'.succ      # => 'abce'
'THX1138'.succ   # => 'THX1139'
'<<koala>>'.succ # => '<<koalb>>'
'1999zzz'.succ   # => '2000aaa'
'ZZZ9999'.succ   # => 'AAAA0000'
'***'.succ       # => '**+'
'zzz'.next       # => 'aaaa'
##############################


## Struct
###########################
# создаем класс с готовыми геттерами и сеттерами
Customer = Struct.new(:name, :address) do
  def to_s
    "#{name} lives at #{address}"
  end
end

Customer.new('Jim', '-1000 Wall Street').to_s
##########
require 'ostruct'
some_object        = OpenStruct.new(name: 'Joe', age: 15)
some_object.sure   = 'three'
some_object.really = 'yes, it is true'
some_object.digit  = 10
puts "#{some_object.name} #{some_object.age} #{some_object.really}"
###########################


##loops
##############################
# redo  - повторяет текущий итератор в цикле
# retry - повторяет цикл с начала
# next  - пропускает текущий итератор
# break - выходит из цикла
##########
numbers.each { |item| puts item }
##########
numbers.each do |item|
  puts item
end
##########
arr = %w{Hi my name is Borya}
arr.each_with_index do |x, index|
  arr[index] = 'Vova' if x == 'Borya'
end
print arr # => [Hi, my, name, is, Vova]
##########
i = 0
while i < 3
  i += 1
end
##########
until i > 3
  i += 1
end
##########
for i in 0..2; end
##########
for i in (1..4).reverse_each; end
##########
3.times { puts 'Hello World' }
##########
times_2 = 2
times_2 *= 2 while times_2 < 100
times_2 *= 2 until times_2 >= 100
##########
loop do
  break if true
end
##########


## Enumerator
##############################
e = [1, 2, 3].map                  # => #<Enumerator: [1, 2, 3]:map>
e.each_with_index { |n, i| n * i } # => [0, 2, 6]

[1, 2, 3].map.with_index { |n, i| n * i } # => [0, 2, 6]
###########
letters = %w[a b c d e]

group_1 = letters.reverse_each.group_by.each_with_index do |item, index|
  index % 3
end

group_2 = letters.reverse_each.each_with_index.group_by do |item, index|
  index % 3
end

p group_1 # => {0=>["e", "b"], 1=>["d", "a"], 2=>["c"]}
p group_2 # => {0=>[["e", 0], ["b", 3]], 1=>[["d", 1], ["a", 4]], 2=>[["c", 2]]}
###########
numbers = [1,2].cycle(1) # => #<Enumerator: [1, 2]:cycle(1)>
numbers.next             # => 1
numbers.next             # => 2
numbers.next             # StopIteration: iteration reached an end
###########
numbers = [1,2].cycle(1) # => #<Enumerator: [1, 2]:cycle(1)>
loop { p numbers.next } # => 1, 2
###########
e = [1, 2, 3].each # => #<Enumerator: [1, 2, 3]:each>
e.next   # => 1
e.peek   # => 2
e.next   # => 2
e.rewind # => #<Enumerator: [1, 2, 3]:each>
e.next   # => 1
##############################


## Arrays
##############################
# push or <<   # append
# pop or shift # remove
###########
Array('firefly') # => ['firefly']
###########
[1, 2, 3].count # bad, count iterate all collection
[1, 2, 3].size  # good
###########
[1, 2, 3].reverse.each(:to_s) # bad
[1, 2, 3].reverse_each(:to_s) # good
###########
[[1, 2, 3], [4, 5, 6]].flatten == [1, 2, 3, 4, 5, 6]
###########
very_long_array =
  ['elemrnt_number_n', 'elemrnt_number_n', 'elemrnt_number_n', 'elemrnt_number_n',
   'elemrnt_number_n',
   'elemrnt_number_n', 'elemrnt_number_n', 'elemrnt_number_n', 'elemrnt_number_n']
###########
first, *list = [1, 2, 3, 4, 5]
first # => 1
list  # => [2,3,4,5]
###########
hello_array = *'Hello'
###########
a = *(1..3) # => [1,2,3]
###########
# отбросить последний элемент массива
*begining, _last = '0, 1, 2, 4, 8, 16, 32'.split(', ')
begining # => ["0", "1", "2", "4", "8", "16"]
_last    # => "32"
###########
a = [2, 4, 8]
a.push(16, 32)  # a => [2, 4, 8, 16, 32]
a.unshift(0, 1) # a => [0, 1, 2, 4, 8, 16, 32]
puts a.shift    # a => [1, 2, 4, 8, 16, 32] выводим на экран первый элемент массива и удаляем его из массива
puts a.pop      # a => [1, 2, 4, 8, 16] выводим на экран последний элемент массива и удаляем его из массива
<< == push
###########
[1, nil, 3, nil, nil].compact # => [1, 3]  delete nil from array
###########
a = [1, 2, 3]
b = [3, 4, 5]
c = a & b # 3
c = (a - b) | (b - a) # 1, 2, 4, 5
###########
arr_words = %w{what a great day today!}
puts arr_words[-2]       # => day (what - 0 element, today - -1 elem, day - -2 elem)
puts arr_words[-3, 2]    # => ["great", "day"] (go back 3 and take 2)
puts arr_words[2..4]     # => ["great", "day", "today!"]
puts arr_words.join(',') # => what,a,great,day,today!
###########
puts [1, 2, 3].sample(2) # выводит случайные два элемента массива random
(1..10000).to_a.sample(23)
###########
arr = [1, 3, 8888, 9999, 7777, 3333, 6666]
arr.select { |element| element % 3 == 0 }
arr.reject { |element| element < 5000 }
arr.sort.reverse
###########
95.upto(100)  { |num| print num, ' ' } # Prints 95 96 97 98 99 100
45.downto(40) { |num| print num, ' ' } # Prints 45 44 43 42 41 40
'L'.upto('P') { |x| print x, ' ' }     # Prints L M N O P
###########


#word frequency count histogram
word_frequency = Hash.new(0)
'Chicka chicka boom boom'.split.each do |word|
  word_frequency[word.downcase] += 1
end

p word_frequency # => {"chicka" => 2, "boom" => 2}
word_frequency = Hash[word_frequency.sort] #destructive sort by key
word_frequency = Hash[word_frequency.sort_by { |k, v| v }.reverse] #destructive sort by value
puts word_frequency
############################


## CLASSES & Modules
##############################
class Angle
  include Math # include module and now we don't want to type Math::

  def cosine
    cos(@radians) #before - Math::cos ; after - cos
  end
end
Angle.new(1).cosine
###
class MathFunctions
  def self.double(var) # 1. Using self
    times_called; var * 2;
  end

  class << self # 2. Using << self
    def times_called
      @@times_called ||= 0; @@times_called += 1
    end
  end
end

def MathFunctions.triple(var) # 3. Outside of class
  times_called; var * 3
end

puts MathFunctions.double 5 # => 10
puts MathFunctions.triple(3) # => 9
puts MathFunctions.times_called # => 3
###
class Person
  @@people_count = 0

  def initialize(name)
    @name          = name
    # Increment your class variable on line 8
    @@people_count += 1
  end

  def self.number_of_instances
    @@people_count
  end
end
matz = Person.new('Yukihiro')
dhh  = Person.new('David')
puts "Number of Person instances: #{Person.number_of_instances}"
##############################


#default arguments
def max(one_param, *numbers, &block) #numbers - это массив, в него входят все переданые
  # параметры кроме первого и последенго
  numbers.max
end

puts max('something', 7, 32, -4, 'more') # ==> 32
############################


##BLOCKS
############################
def meth(a, b, &block)
  3 + yield(a, b) if block_given?
end

meth(1, 2) { |x, y| x + y } # => 3 + (1 + 2) = 6
###
1.times do
  puts 'I\'m a code block!'
end
1.times { puts 'As am I!' }
##########
[:weezard, 42, 'Trady Blix', 3, true, 19, 12.345].map { |x| x.is_a? Integer } # => [42, 3, 19]
##########
def double (par)
  yield par
end

double (2) { |x| puts x * 2 }
##########
def doub
  yield
end

puts doub { 2 * 2 } # вызываешь метод и передаешь туда параметры
###############################


###############################
# Отличия лямбды от прока
def meth
  la =   -> { return 10 }   # return возвращает из лямбды в метод
  pr = proc { return 20 } # return возвращает из метода
  return 1 + 2 # не выполняется из-за proc's return
end

###
pr = proc { |x, y| x + y }
pr.arity # => 2 аргумента передано
pr.call(1, 2, 99) # => 3, можно передать больше аргументов и все ок

la = -> (x, y) { x + y }
la.arity # => 2 аргумента передано
la.call(1, 2, 99) # => ошиька, можно передать строгое кол-во аргументов
###############################


## Proc
###############################
###
cube = Proc.new { |x| x ** 3 }
# or
cube = proc { |x| x ** 3 }
[1, 2, 3].collect!(&cube) # ==> [1, 8, 27]
##########
round_down = proc { |x| x.floor } # The .floor method rounds a float (a number with a decimal) down to the nearest integer.
[1.2, 3.45, 0.91, 7.727, 11.42, 482.911].collect(&round_down)
##########
def greeter
  puts 'We\'re in the method'
  yield('John Doe')
end

phrase = Proc.new { |x| puts "Hello there #{x}!" }
greeter(&phrase)
##########
hi = Proc.new { puts 'Hello' }
hi.call
##########
%w[1 2 3].map(&:to_i) # convert strings to int
# ==> [1, 2, 3]
##########
under_100 = Proc.new { |x| x < 100 }
[23, 101, 7, 104, 11, 94, 100, 121, 101, 70, 44].select(&under_100)
# => [23, 7, 11, 94, 70, 44]
###############################


## Lambdas
###############################
succ = -> (x) { x + 1 }
succ.call(2)
###
def lambda_demo(a_lambda)
  puts 'I\'m the method!'
  a_lambda.call
end

lambda_demo(lambda { puts 'I\'m the lambda!' })
# or
lambda_demo { puts 'I\'m the lambda!' }
# ==> I'm the method!
# ==> I'm the lambda!
##########
symbolize = lambda { |x| x.to_sym }
symbols   = %w[leonardo donatello raphael michaelangelo].map(&symbolize)
##########
def batman_ironman_proc
  victor = Proc.new { return 'Batman will win!' } # it returns immediately, without going back to the batman_ironman_proc method
  victor.call
  'Iron Man will win!'
end

puts batman_ironman_proc

def batman_ironman_lambda
  victor = lambda { return 'Batman will win!' }
  victor.call
  'Iron Man will win!' # returns the last code
end

puts batman_ironman_lambda

# ==> Batman will win!
# ==> Iron Man will win!

##########
symbol_filter = lambda { |x| x.is_a? Symbol }
symbols       = ['raindrops', :kettles, 'whiskers', :mittens, :packages].select(&symbol_filter)
# ==> [:kettles, :mittens, :packages]
##########
crew          = {
  captain:        'Picard',
  first_officer:  'Riker',
  lt_cdr:         'Data',
  lt:             'Worf',
  ensign:         'Ro',
  counselor:      'Troi',
  chief_engineer: 'LaForge',
  doctor:         'Crusher'
}

first_half = lambda { |key, value| value < 'M' }
a_to_m     = crew.select(&first_half)
# => {:lt_cdr=>"Data", :chief_engineer=>"LaForge", :doctor=>"Crusher"}
##########
###############################


## compare
###############################
book_1 = 'A Wrinkle in Time'
book_2 = 'A Brief History of Time'
book_1 <=> book_2 #compare
############
books = ['Charlie and the Chocolate Factory', 'War and Peace', 'Utopia', 'A Brief History of Time', 'A Wrinkle in Time']
# To sort our books in ascending order, in-place
books.sort! { |firstBook, secondBook| secondBook <=> firstBook }
###############################


## замыкание
##############################
# замыкание, т.е в блоке будет использоваться своя переменная number
puts number = 99 # => 99
10.times { |i; number | puts number = 123 }
puts number # => 99
##############################


##File
##############################
# open
file = File.open('path', 'r')
while line = file.readline;
end
#read
File.foreach('test.txt') { |line| puts line.chomp } if File.exist? 'test.txt'
#write
# w - переписать, a - дописать
File.open('test1.txt', 'w') { |file| file.puts 'One line' }
# load file in class
def load_file
  load 'file.rb'
end
##############################


##Strings
##############################
cur_weather = %Q{It's a hot day outside
					 Grab your umbrellas…} # сколько строк записали столько и выведится

cur_weather.lines do |line|
  line.sub! 'hot', 'rainy' # substitute 'hot' with 'rainy'
  puts "#{line.strip}" # убирает все пробелы во всех строках
end
# 'It\'s a rainy day outside'
##########
'Hello'.include? 'lo' #true
'Hello'.include? ?h #true
##########
puts 'hello'.methods.grep /case/ #выводит все методы относящиеся к string и содержащие case
puts 'hello'.casecmp 'HeLlo' #сравнивает строки игнорируя регистр
##########
'Yukihiro ' << 'Matsumoto'
# ==> "Yukihiro Matsumoto"
##############################

#regexp
###############################
['Dmitry Sadovnikov', 'Ivan Ivanov'].each do |r|
  matches    =/(\w+) (\w+)/.match r
  first_name = matches[1]
  last_name  = matches[2]
  puts first_name
  puts last_name
end
###############################


### protected
class C
  def initialize(number)
    @number = number
  end

  def compare(c)
    if c.number > number
      puts "The other object's number is bigger."
    else
      puts "The other object's number is the same or smaller."
    end
  end

  protected

  def number
    @number
  end
end

c1 = C.new(100)
c2 = C.new(101)
c1.compare(c2)
##########


# METHAPROGRAMMING
## Modules
##############################
# Meta class
def add_checked_attribute(klass, attribute)
  eval "
    class #{klass}
      def #{attribute}=(value)
        raise 'Invalid attribute' unless value
         @#{attribute} = value
       end

      def #{attribute}()
        @#{attribute}
      end
    end
  "
end

add_checked_attribute('Jopa', 'name')
###
class A
  def foo
    bar do
      <<~EOF
        texttext
          text
      EOF
    end
  end
end

class A
  def foo
    bar do
      <<EOF
texttext
  text
EOF
    end
  end
end
###
# Переобределяем методы в другом классе
class MyClass
  def my_method
    'original method'
  end
end
module MyClassRefinement
  refine MyClass do
    def my_method
      'refined my method'
    end
  end
end
using MyClassRefinement
MyClass.new.my_method # 'efined my method'
###
# missing methods
#if metdod didnt define you will not see error you will see a message "sorry..."
class Mistery
  def method_missing (method, *args)
    puts 'Looking for'
    puts "\"#{method}\" with params (#{args.join(',')}) ?"
    puts 'Sorry... He is on vacation...'
    yield 'Ended up in method_missing' if block_given?
  end
end

m = Mistery.new
m.solve_mistery('abc', 123123) do |answer|
  puts "And the answer is: #{answer}"
end
###
# доступ к приватным переменным
class KlassWithSecret
  def initialize
    @secret = 99
  end

  private
  def the_secret
    "Ssssh! The secret is #{@secret}."
  end
end
k = KlassWithSecret.new
k.instance_eval { @secret } #=> 99
k.instance_eval { the_secret } #=> "Ssssh! The secret is 99."
###
class MyClass
  def name
    'Dima'
  end

  deprecate :name
  alias_method :first_name, :name
end
MyClass.new.name
# DEPRECATION WARNING: name is deprecated and will be removed from Rails 5.0. (called from irb_binding at (irb):933)
# => "Dima"
###
# aliases
class MyClass
  def name
    'Dima'
  end

  alias_method :first_name, :name
end
MyClass.new.name # => Dima
MyClass.new.first_name # => Dima
###

# singleton classes
obj             = Object.new
singleton_class = class << obj
  self
end

def obj.my_singleton_method
  'Dima'
end

obj.my_singleton_method # => 'Dima'

module LastName
  mattr_accessor :last_name
end
obj.extend LastName
obj.last_name = 'Sadovnikov'
obj.last_name # => 'Sadovnikov'
###

# meta squared
class << 'abc'
  class << self
    self # => #<Class:#<Class:#<String:0x33552c>>>
  end
end
###
class MyClass
  class << self
    attr_accessor :c
  end
end
MyClass.c = 'It works!'
MyClass.c # => "It works!"
###


# my hash
class Mash
  def self.[](method_name)
    puts method_name
  end
end
Mash[:xxx]
###
# generate methods
class Computer
  def initialize(comp_id, data_source)
    @id          = comp_id
    @data_source = data_source
    data_source.methods.grep(/^get_(.*)_info$/) { Computer.define_component $1 }
  end

  def self.define_component(name)
    define_method(name) do
      info   = @data_source.send "get_#{name}_info", @id
      price  = @data_source.send "get_#{name}_price", @id
      result = "#{name.capitalize}: #{info} ($#{price})"
    end
  end
end
my_computer = Computer.new(42, DS.new)
my_computer.cpu # => Cpu: 2.9 Ghz ...
###
# alternative class definition
MyClass = Class.new do
  define_method...
end
###
# able to call instance vars without attr_accessor
class C
  def initialize
    @x = 1
  end
end
C.new.instance_eval { "#{@x}" } # as puts
C.new.instance_exec { |x| puts @x } # as call
###
# С помощью prepend методы модуля устанавливаются первоочередными при поиске метода в классе, в который подключен модуль.
module ExplicitString
  def length
    super > 5 ? 'long' : 'short'
  end
end
String.class_eval do
  prepend ExplicitString
end
'War and Peace'.length
###


# eval methods in loop
POSSIBLE_VERBS = ['get', 'put', 'post', 'delete']
POSSIBLE_VERBS.each do |m|
  eval <<-end_eval
    def #{m}(path, *args, &b)
      r[path].#{m}(*args, &b)
    end
  end_eval
end
###
# Позволяет делать eval у объектов класса
class Demo
  def initialize(n)
    @secret = n
  end

  def get_binding
    binding
  end
end
k1 = Demo.new(99)
b1 = k1.get_binding
k2 = Demo.new(-3)
b2 = k2.get_binding
eval('@secret', b1) #=> 99
eval('@secret', b2) #=> -3
eval('@secret') #=> nil
###


# methods
# define_methods
class Whatever
  [:aaa, :bbb, :ccc].each do |x|
    define_method x do
      puts "it's method #{x}"
    end
  end
end
w = Whatever.new
w.aaa

class MyClass
  define_method(:my_method) { |my_arg| my_arg * 3 }
end
MyClass.new.my_method(2) # => 6
###

# delete method from class
undef_method :my_method
###


#calling methods dynamically
dog.send(:bark) #=> Woof, woof!
method_name = :bark
dog.send method_name # => Woof, woof!
dog.public_send(:greet, "Hello") # send method with params
###
Order.last.send(:email)
Order.last.one_s_log_info.send(:[], 'сompany_tel')
###
def sum(a, b)
  a + b
end

method('sum').call(1, 2) # => 3
###
# UnboundMethod
m = Object.instance_method(:presence)
m.class # => UnboundMethod
# add method to a class
def add_method_to(a_class)
  a_class.class_eval do
    def new_method
      'Hello'
    end
  end
end

add_method_to String
'abc'.new_method # => 'Hello'
###
# singleton methods
str = 'There is just string'

def str.title?
  self.upcase == self
end

str.title? # => false
str.singleton_methods # => [:title?]
###
##############################


# reserved words
# break case catch class const continue debugger default delete do else enum
# export extends false finally for function if implements import in instanceof
# interface let new null package private protected public return static super
# switch this throw true try typeof var void while with yield end
###


### Algorithms
##############################
# factorial
def factorial_recursive(n)
  n == 0 ? 1 : n * factorial_recursive(n - 1)
end

def factorial_iterative(n)
  (1..n).inject(:*)
end

class Integer
  def factorial_iterative
    (1..self).inject(:*) || 1
  end
end
##########


# fibonacci
def fibonacci_iterative(n)
  (0..n).each_with_object([]) { |i, seq| seq << (i < 2 ? i : seq[-1] + seq[-2]) }.last
end

def fibonacci_recursive(n)
  n < 2 ? n : fibonacci_recursive(n - 1) + fibonacci_recursive(n - 2)
end
##############################
