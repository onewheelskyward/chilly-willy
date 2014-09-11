class ChillyWilly
  include DataMapper::Resource
  attr_accessor :expired

  property :id,         Serial
  property :boogalooga, String, length: 2000  # Hey, key is a reserved word.
  property :cooldown,   Integer
  property :start_time, Integer

  # def initialize(key, cooldown)
  #   self.boogalooga = key
  #   self.cooldown = cooldown
  #   self.start_time = get_current_timestamp
  #   self.save
  # end

  def is_expired?
    (get_current_timestamp - self.start_time >= self.cooldown)? true : false
  end

  def time_to_expire
    tte = get_current_timestamp - self.start_time
    if tte >= self.cooldown
      0
    else
      cooldown - tte
    end
  end

  def get_current_timestamp
    Time.now.getutc.to_i
  end

  def expire
    self.cooldown = 0
  end

end
