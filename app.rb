require 'sinatra/base'
require 'data_mapper'
require 'dm-postgres-adapter'
require 'json'

require_relative 'lib/chilly_willy'

class App < Sinatra::Base
  config = YAML.load_file(File.dirname(__FILE__) + '/config.yml')

  database = config[:db]
  configure :test do
    database = config[:test_db]
  end

  DataMapper::Logger.new($stdout, :debug)
  DataMapper.setup(:default, "postgres://#{config[:db_user]}:#{config[:db_password]}@#{config[:db_host]}/#{database}")

  ChillyWilly.auto_upgrade!

  get '/' do
    'x'
  end
end
