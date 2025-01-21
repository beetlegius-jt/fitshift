module HasCompany
  extend ActiveSupport::Concern

  included do
    before_action :set_current_attributes

    def set_current_attributes
      Current.user = current_user if user_signed_in?
      Current.company = Company.find_by(subdomain: request.subdomain)
    end
  end
end
