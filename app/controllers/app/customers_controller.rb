module App
  class CustomersController < BaseController
    def show
      @customer = authorize Current.customer

      set_metadata title: @customer.name
    end
  end
end
