class VirtualSchedule
  include ActiveModel::Model

  attr_accessor :starts_on
  attr_accessor :utc_offset
  attr_accessor :rules

  def initialize(attributes = {})
    super attributes.with_defaults(
      starts_on: Time.zone.today,
      utc_offset: 0,
      rules: []
    )
  end

  def rules_attributes=(attributes)
    @rules = attributes.values.map { |attrs| VirtualRule.new(attrs) }
  end
end
