module Public
  class SiteController < BaseController
    def index
      @company = Company.new
      @company.users.build
    end
  end
end
