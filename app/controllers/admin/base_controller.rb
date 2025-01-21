module Admin
  class BaseController < ApplicationController
    include HasCompany
    include ErrorHandler

    before_action :authenticate_user!
    after_action :verify_authorized
  end
end
