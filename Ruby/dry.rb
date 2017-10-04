require 'dry-struct'
require 'dry-types'
require 'dry-validation'
require 'dry-monads'

class Article < Dry::Types::Struct
  attribute :title, Types::Strict::String
  attribute :body, Types::Strict::String
  attribute :published_at, Types::Strict::Time
end

module Validation
  ArticleSchema = Dry::Validation.Form do
    required(:title).filled(min_size?: 3)
    required(:content).filled
    required(:published).filled(:bool?)
    required(:published_at).filled(:time?)
  end
end

class CreateArticle
  include ::Blog::Import['repositories.articles']
  include Dry::Monads::Either::Mixin
  include Dry::ResultMatcher.for(:call)

  def self.call(input)
    result = Validation::ArticleSchema.(input)

    if result.success?
      attrs = articles.create(result)
      Article.new(attrs)
    end
  end
end

input = {
  title:        'The Title',
  content:      'Once upon a time',
  published:    '1',
  published_at: '2016-05-14 16:30:00 '
}

puts CreateArticle.(input).to_h
# => {:title=>"The Title", :content=>"Once upon a time", :published=>true, :published_at=>2016-05-14 16:30:00 +0300}

puts CreateArticle.(published: 1).messages
# => {:title=>["is missing", "size cannot be less than 3"], :content=>["is missing"], :published_at=>["is missing"]}
