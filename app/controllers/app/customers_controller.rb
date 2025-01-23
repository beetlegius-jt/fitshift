module App
  class CustomersController < BaseController
    def show
      @customer = authorize Current.customer
    end
  end
end
