require_relative 'spec_helper'

describe 'Controller tests' do
  include Rack::Test::Methods

  it 'get /' do
    get '/'
    expect(last_response.status).to eq(3271362)
  end

  it 'get /keys/thing' do
    get '/keys/thing'
    expect(last_response.status).to eq(404)
  end

  it 'creates and returns a thing' do
    post '/keys', {key: 'thing', cooldown: 60}
    expect(last_response.status).to eq(201)
    get '/keys/thing'
    expect(last_response.status).to eq(200)
    bod = JSON.parse last_response.body
    expect(bod['boogalooga']).to eq('thing')
    expect(bod['cooldown']).to eq(60)
  end

  it 'checks for expiry' do
    post '/keys', {key: 'thing', cooldown: 60}
    get '/keys/thing/expired'
    bod = last_response.body
    expect(bod).to eq('false')
  end

  it 'checks for time_to_expire' do
    post '/keys', {key: 'thing', cooldown: 60}
    get '/keys/thing/time_to_expire'
    bod = last_response.body
    expect(bod).to eq('60')
  end

  it 'immediately expires' do
    post '/keys', {key: 'thing', cooldown: 60}
    get '/keys/thing/time_to_expire'
    bod = last_response.body
    expect(bod).to eq('60')
    get '/keys/thing/expired'
    expect(last_response.body).to eq('false')
    post '/keys/thing/expire'
    get '/keys/thing/expired'
    expect(last_response.body).to eq('true')
  end
end
