class ChillyWilly
  @key = nil
  @cooldown = nil
  @start_time = nil

  def initialize(key, cooldown)
    self.key = key
    self.cooldown = cooldown
    self.start_time = Time.now
  end

  def expired?
    if Time.now - self.start_time >= self.cooldown
      true
    end
  end

  def time_to_expire
    tte = self.cooldown - Time.now - self.start_time
    if tte < 0
      0
    else
      tte
    end
  end

  def expire
    self.cooldown = 0
  end

end
