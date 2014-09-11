require 'rspec'
require_relative '../lib/chilly_willy'

describe 'ChillyWilly tests' do
  it 'exists' do
    chilly = ChillyWilly.new
    expect(chilly).to_not be(nil)
    expect(chilly.is_a?(ChillyWilly)).to eq(true)
  end

  it 'stores a cooldown' do
    chilly = ChillyWilly.new
    chilly.boogalooga = 'key'
    chilly.cooldown = 60
    chilly.start_time = chilly.get_current_timestamp
    expect(chilly.time_to_expire).to eq(60)
  end

  it 'tests a cooldown time until expiration' do
    chilly = ChillyWilly.new
    chilly.boogalooga = 'key'
    chilly.cooldown = 10
    chilly.start_time = chilly.get_current_timestamp
    Delorean.jump 1
    expect(chilly.time_to_expire).to eq(9)
  end

  it 'tests a cooldown expiration' do
    chilly = ChillyWilly.new
    chilly.boogalooga = 'key'
    chilly.cooldown = 1
    chilly.start_time = chilly.get_current_timestamp
    Delorean.jump 1
    expect(chilly.is_expired?).to eq(true)
  end

  it 'expires immediately' do
    chilly = ChillyWilly.new
    chilly.boogalooga = 'key'
    chilly.cooldown = 10000
    chilly.start_time = chilly.get_current_timestamp
    expect(chilly.time_to_expire).to eq(10000)
    expect(chilly.is_expired?).to eq(false)
    chilly.expire
    expect(chilly.is_expired?).to eq(true)
    expect(chilly.time_to_expire).to eq(0)
  end

  it 'gets a utc timestamp' do
    chilly = ChillyWilly.new
    expect(chilly.get_current_timestamp).to eq(Time.now.getutc.to_i)
  end
end
