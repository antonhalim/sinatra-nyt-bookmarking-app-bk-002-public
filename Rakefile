ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'
Dir.glob('lib/tasks/*.rake').each { |r| load r}

task :console do 
  Pry.start
end
