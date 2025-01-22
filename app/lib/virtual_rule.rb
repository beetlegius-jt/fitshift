class VirtualRule
  include ActiveModel::Model

  attr_accessor :day
  attr_accessor :hour_of_day
  attr_accessor :minute_of_hour

  def time
    @time ||= Time.zone.now.change(hour: hour_of_day, min: minute_of_hour)
  end

  define_method "time(5i)=" do |str|
    time = str.to_time

    self.hour_of_day = time.hour
    self.minute_of_hour = time.min
  end

  def day=(day)
    @day = day.compact_blank.map(&:to_i)
  end
end
