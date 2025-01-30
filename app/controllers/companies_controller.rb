class CompaniesController < ApplicationController
  layout false

  before_action :protect
  before_action :set_company

  def show
    set_metadata title: @company.name
  end

  private

  def set_company
    @company = Current.company
  end

  def protect
    return unless user_signed_in?

    redirect_to admin_root_path if Current.user.company?
    redirect_to app_root_path if Current.user.customer?
  end
end
