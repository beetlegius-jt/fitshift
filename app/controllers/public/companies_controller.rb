module Public
  class CompaniesController < BaseController
    def create
      @company = Company.new company_params
      @company.save!

      redirect_to user_session_url(subdomain: @company.subdomain), allow_other_host: true
    end

    private

    def company_params
      params.require(:company).permit(:name, :subdomain, :utc_offset, users_attributes: [ :email, :password, :password_confirmation ])
    end
  end
end
