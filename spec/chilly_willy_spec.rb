require 'rspec'
require_relative '../lib/chilly_willy'

describe 'ChillyWilly tests' do
  it 'exists' do
    chilly = ChillyWilly.new
    expect(chilly).to_not be(nil)
    expect(chilly.is_a?(ChillyWilly)).to eq(true)
  end
end
