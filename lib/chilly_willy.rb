class ChillyWilly
  attr_accessor :key, :cooldown, :start_time

  def initialize(key, cooldown)
    self.key = key
    self.cooldown = cooldown
    self.start_time = get_current_timestamp
  end

  def expired?
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
