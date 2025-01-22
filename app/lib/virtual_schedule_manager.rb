module VirtualScheduleManager
  module_function

  def deserialize(ice_cube)
    return VirtualSchedule.new unless ice_cube.present?

    starts_on = ice_cube.start_time.to_date
    utc_offset = ice_cube.start_time.utc_offset
    rules = ice_cube.rrules.map do |rrule|
      days, hours, minutes = rrule.validations.values_at(:day, :hour_of_day, :minute_of_hour)

      VirtualRule.new(
        day: days.map(&:day),
        hour_of_day: hours&.first&.hour,
        minute_of_hour: minutes&.first&.minute
      )
    end

    VirtualSchedule.new(starts_on:, utc_offset:, rules:)
  end

  def serialize(schedule_params)
    vschedule = VirtualSchedule.new(schedule_params)

    IceCube::Schedule.from_hash(
      start_time: { time: vschedule.starts_on.to_date, zone: vschedule.utc_offset.to_i },
      rrules: vschedule.rules.map do |vrule|
        {
          validations: {
            day: vrule.day,
            minute_of_hour: vrule.minute_of_hour,
            hour_of_day: vrule.hour_of_day
          },
          rule_type: "IceCube::WeeklyRule",
          interval: 1,
          week_start: 0
        }
      end
    ).to_hash
  end
end
