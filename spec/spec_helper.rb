ENV['RACK_ENV'] = 'test'
require 'rack/test'
require 'rspec'
require 'data_mapper'
require_relative '../lib/chilly_willy'
require_relative '../app'
require 'delorean'
# set :environment, :test

RSpec.configure do |config|
#  config.include Sinatra::Helpers
  config.include Rack::Test::Methods
end

def app
  App
end
