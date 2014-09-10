require_relative 'spec_helper'

describe 'Controller tests' do
  include Rack::Test::Methods

  it 'get /' do
    get '/'
    expect(last_response.body).to eq('x')
  end
end
