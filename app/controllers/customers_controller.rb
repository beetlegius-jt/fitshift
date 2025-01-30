class CustomersController < ApplicationController
  def new
    @customer = Customer.new

    render :form
  end

  def create
    @customer = Customer.new customer_params
    @customer.save!

    sign_in(@customer.users.first)

    redirect_to app_root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :picture, users_attributes: [ :email, :password, :password_confirmation ])
  end
end
