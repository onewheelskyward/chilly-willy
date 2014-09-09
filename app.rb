require 'sinatra/base'
require 'data_mapper'
require_relative 'lib/chilly_willy'

class App < Sinatra::Base
  config = YAML.load_file(File.dirname(__FILE__) + '/config.yml')

  DataMapper.setup(:default, "postgres://#{config[:db_user]}:#{config[:db_password]}@#{config[:db_host]}/#{config[:db]}")
end
