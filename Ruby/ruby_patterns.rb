####################################
####################################
# STI             — Одна таблица и много моделей
# Template method - Когда есть, необходимые имплементировать
# Adapter         - В зависимомсти от передаваемого параметра вызывает разные методы класса или вызвать опред класс
# Strategy        - Когда есть единый базовый класс с базовыми методами
# Decorator       - Прячет методы
# Factory         - Очень похож на адаптер, вызывает класс в зависимости от передаваемого объекта
# Iterator        - Метод с блоком для итерации
# Visitor         - В зависимости от класса прешедшей переменной вызывает определенный метод
# Observer        - Следит за изменениями в классе
# Singleton       - Возвращает всегда один и тотже объект
# State           - Указываем в каком статусе находится объект
# Builder         - Создаёт объекты класса, относяшиеся к текущему классу (создает внутри него)

####################################

######### template method ##########
# Когда есть, необходимые имплементировать

Generators::Markdown.new.header

# При добавлении нового метода будут ошибки в классах наследниках, 
# делаем это чтобы не забыть имплементировать их
module Newsletter
  class Generator
    def header
      raise NotImplementError # !!
    end

    def content
      raise NotImplementError
    end
  end
end

module Newsletter
  module Generators
    class Markdown < Generator
      def header
        'Hello'
      end

      def content
        'World'
      end
    end
  end
end

############# Strategy #############
# Когда есть единый базовый класс с базовыми методами

Generators::Base.new(:markdown).render # внутри base я вызываю класс mardown
# в котором прописана вся логика
module Newsletter
  module Generators
    class Base # !

      attr_accessor :format, :title, :phrase

      def initialize(format = :html)
        @format = format
        @title  = 'Hello world!'
        @phrase = 'Lorem Ipsum'
      end

      def render # !
        name     = format.to_s.capitalize
        strategy = Newsletter::Generators.const_get(name).new self # вызываем наследника по имени
        strategy.execute
      end

      def header
        raise NotImplementError
      end

      def content
        raise NotImplementError
      end
    end
  end
end

require 'forwardable'
module Newsletter
  module Generators
    class Markdown
      extend Forwardable

      def_delegators :@context, :title, :phrase

      def initialize context
        @context = context
      end

      def execute
        "#{header} #{content} #{Date.today}"
      end

      def header
        %(# #{title})
      end

      def content
        phrase
      end
    end
  end
end

############# Adapter ##############
# В зависимомсти от передаваемого параметра вызывает разные методы класса или вызвать опред класс

Content.parse(@json, :json) # передаем json и флаг, определяющий формат объекта (это может быть xml)

module Newsletter
  class Content

    attr_reader :title, :body

    def self.parse source, format
      adapter = Newsletter::Adapters::const_get(format.to_s.capitalize).new(source)
      content = adapter.parse
      new(content['title'], content['body'])
    end

    def initialize title, body
      @title = title
      @body  = body
    end
  end
end

module Newsletter
  module Adapters
    class Json

      attr_reader :source

      def initialize source
        @source = source
      end

      def parse
        JSON.parse source
      end
    end
  end
end

module Newsletter
  module Adapters
    class Xml

      attr_reader :source

      def initialize source
        @source = source
      end

      def parse
        xml   = Nokogiri::Xml source
        title = xml.xpath('//item/title')[0].children[0].text
        body  = xml.xpath('//item/body')[0].children[0].text
        { 'title' => title, 'body' => body }
      end
    end
  end
end

########### Decorator ##############
product_decorator = ProductDecorator.new product
product_decorator.as_html_row

require 'forwardable'

class Product
  attr_reader :name, :category, :tags

  def initialize name, category, tags = []
    @name     = name
    @category = category
    @tags     = tags
  end
end

class ProductDecorator
  extend Forwardable

  def_decorators :@context, :name, :category, :tags

  def initialize context
    @context = context
  end

  def as_html_row
    '<<'EOF
     <tr>
       <th>#{name}</th>
       <td>#{category}</td>
     <tr>
     EOF
   end
end

############ Factory ###############
# Очень похож на адаптер, вызывает класс в зависимости от передаваемого объекта

# call methods
user    = User.new 'John Doe'
service = PaymentServiceFactory.for user
service.pay

class PaymentServiceFactory
  def self.for(entity)
    if entity.is_a User
      return UserPaymentService.new
    elsif entity.is_a Manager
      return ManagerPaymentService.new
    end
  end
end

class UserPaymentService
  def pay user, amount
    puts 'hello'
  end
end

############ Iterator ##############
# Iterator - метод с блоком для итерации

family = Family.new # has instance vars @father, @mother, @children
family.each_member { |member| puts family.full_name member }

class Family
  def each_member
    [@father, @mother, @children].flatten.each { |member| yield member }
  end

  def full_name member
    "#{member.first_name} #@surname"
  end
end
####################################
####################################
####################################




####################################
####################################






###############################
class UsersController < ApplicationController
  def create
    registration = UserRegistration.new(user_params)
    @user = registration.user

    if registration.create
      redirect_to @user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :ssn, :address)
  end
end


class UserRegistration
  attr_reader :user

  def initialize(params)
    @user = User.new(params)
  end

  def create
    if valid_background_check?
      user.is_approved = true
    end

    user.save
  end

  private

  def valid_background_check?
    !!(@user.valid_ssn? || @user.valid_address?)
  end
end

###############################

#scopes
###############################
class Post < ActiveRecord
  def self.recent
    where('published = ? AND published_on > ?', true, 2.days.ago)
  end
  # or
  scope :recent, -> { where('published_on > ?', 2.days.ago) }


  def self.by_author(author)
    if author.present?
      where(author: author)
    else
      all
    end
  end
  #or
  scope :by_author, ->(author) { where(author: author) if author.present? }


  scope :with_approved_comments, -> { joins(:comments).merge(Comment.approved) }
  # "SELECT "posts".* FROM "posts" INNER JOIN "comments" ON "comments"."post_id" =
  # "posts"."id" WHERE ("comments"."approved" = 't')
end


class User < ActiveRecord::Base
  scope :active,   -> { where(state: 'active') }
  scope :inactive, -> { where(state: 'inactive') }
end
User.active.merge(User.inactive)

###############################

#### Visitor - в зависимости от класса прешедшей переменной вызывает определенный метод ####
Node.accept(9)
Node.accept('9')

class Node
  def accept value
   method_name = "visit_#{value.class}"
   send method_name
  end

  def visit_Integer value
   value * 2
  end

  def visit_String value
    value.to_i * 2
  end
end
########

#### Observer - следит за изменениями в классе ####
user     = User.new('nick', 'My Name', 'Proger')
observer = Observer.new
user.subscribe(observer)
user.update(:user_name, 'new_nick')
  
module Application
  class User
    attr_reader :user_name
    def initialize(user_name, name, job)
      @user_name = user_name
      @name      = name
      @job       = job
      @observers = []
    end

    def subscribe
      @observers << observer
    end

    def update(ke, value)
      instance_variable_set("@#{key}".to_sym, value)
      @observers.each { |o| o.updated(self) }
    end
  end

  class UserObserver
    def updated user
      puts user.user_name
    end
  end
end
########

#### Singleton - возвращает всегда один и тотже объект ####
 PRODUCT = Product.new('Tomato', :fruit)
 class ProductController
   attr_reader :product
   include Singleton
   def show
     @product = PRODUCT
   end
 end
########

#### State - указываем в каком статусе находится объект ####
line = CapProductionLine.new
line.state.class == EngineInstallationState
line.move_to! :hood
line.state.class == HoodInstallationState

class CapProductionLine
  attr_accessor :state

  def initialize
    @state = EngineInstallationState.new self
  end

  def move_to! state
    @state.next state
  end
end

class EngineInstallationState
  def initialize context
    @context = context
  end

  def next(state)
    case state
    when :hood then @context.state = HoodInstallationState.new
    else raise IlleglaStateJumpError
    end
  end
end
########

#### Builder   - создаёт объекты класса, относяшиеся к текущему классу (создает внутри него) ####
plan = RentalPlan.build('My First Plan')

class RentalPlan
  def initialize(metadata, ranges)
    @metadata = metadata
    @ranges   = ranges
  end

  def self.build(name)
    build_metadata name
    build_list_of_ranges
    new(@metadata, @ranges)
  end

  def self.build_metadata(name)
    @metadata = Metadata.new name
  end

  def self.build_list_of_ranges
    @ranges = [DayRange.build]
  end
end
########
