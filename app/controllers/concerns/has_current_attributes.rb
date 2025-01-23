module HasCurrentAttributes
  extend ActiveSupport::Concern

  included do
    before_action :set_current_attributes

    def set_current_attributes
      if user_signed_in?
        Current.user = current_user
        Current.customer = current_user.customer
      end

      Current.company = Company.find_by(subdomain: request.subdomain)
    end
  end
end
