require 'rspec'
require_relative '../lib/chilly_willy'

describe 'ChillyWilly tests' do
  it 'exists' do
    chilly = ChillyWilly.new('key', 1)
    expect(chilly).to_not be(nil)
    expect(chilly.is_a?(ChillyWilly)).to eq(true)
  end

  it 'stores a cooldown' do
    chilly = ChillyWilly.new('key', 60)
    expect(chilly.timeleft).to eq(60)
  end

  it 'tests a cooldown expiration' do
    chilly = ChillyWilly.new('key', 1)
    sleep(1)
    expect(chilly.expired?).to eq(true)
  end

  it 'tests a cooldown time until expiration' do
    chilly = ChillyWilly.new('key', 10)
    sleep(1)
    expect(chilly.time_to_expire).to eq(9)
  end

  it 'expires immediately' do
    chilly = ChillyWilly.new('key', 10000)
    expect(chilly.time_to_expire).to eq(10000)
    expect(chilly.expired?).to eq(false)
    chilly.expire
    expect(chilly.expired?).to eq(true)
    expect(chilly.time_to_expire).to eq(0)
  end

end
