require 'bundler/setup'
Bundler.require

require 'json'
require 'yaml'
require 'open-uri'

ENV['SINATRA_ENV'] ||= "development"

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/bookmarker_#{ENV['SINATRA_ENV']}.sqlite"
)

require_all 'app'