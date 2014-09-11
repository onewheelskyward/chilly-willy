require 'sinatra/base'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'json'

require_relative 'lib/chilly_willy'
require_relative 'lib/controller'

class App < Sinatra::Base
  config = YAML.load_file(File.dirname(__FILE__) + '/config.yml')

  if ENV['RACK_ENV'] == 'test'
    database = config[:test_db]
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(:default, "postgres://#{config[:db_user]}:#{config[:db_password]}@#{config[:db_host]}/#{database}")
    ChillyWilly.auto_migrate!
  else
    database = config[:db]
    DataMapper::Logger.new($stdout, :debug)
    DataMapper.setup(:default, "postgres://#{config[:db_user]}:#{config[:db_password]}@#{config[:db_host]}/#{database}")
    ChillyWilly.auto_upgrade!
  end

end
