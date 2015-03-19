ENV["SINATRA_ENV"] ||= "development"

require 'sinatra/activerecord/rake'
require_relative './config/environment'
Dir.glob('lib/tasks/*.rake').each { |r| load r}

task :console do 
  Pry.start
end
