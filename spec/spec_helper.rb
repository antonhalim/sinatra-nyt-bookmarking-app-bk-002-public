ENV["SINATRA_ENV"] = "test"

require_relative '../config/environment'
require 'rake'
require 'rack/test'
require 'capybara/rspec'
require 'capybara/dsl'

ActiveRecord::Base.logger.level = 2

RSpec.configure do |config|
  config.include Capybara::DSL

  config.include Rack::Test::Methods
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    load_articles
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

def load_articles
  articles = JSON.parse(File.read("db/articles.json"))
  articles["results"].each_with_index do |article|
    Article.create(article)
  end
end

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app
