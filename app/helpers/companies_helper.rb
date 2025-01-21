module CompaniesHelper
  def options_for_utc_offset
    Company::UTC_OFFSETS.map do |utc_offset|
      [ ActiveSupport::TimeZone.seconds_to_utc_offset(utc_offset), utc_offset ]
    end
  end
end
