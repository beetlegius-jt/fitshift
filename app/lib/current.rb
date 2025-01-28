class Current < ActiveSupport::CurrentAttributes
  attribute :user
  attribute :company
  attribute :customer

  after_reset { Time.zone = nil }

  def company=(company)
    super

    Time.zone = company&.utc_offset
  end
end
