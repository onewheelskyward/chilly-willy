require 'simplecov'
SimpleCov.start

ENV['RACK_ENV'] = 'test'
require 'rack/test'
require 'rspec'
require 'data_mapper'
require_relative '../lib/chilly_willy'
require_relative '../app'
# set :environment, :test

RSpec.configure do |config|
#  config.include Sinatra::Helpers
  config.include Rack::Test::Methods
end

def app
  App
end

# Read 'em in and go!
Dir.glob('spec/**/*_spec.rb') { |file| require_relative file.gsub /^spec\//, '' }
