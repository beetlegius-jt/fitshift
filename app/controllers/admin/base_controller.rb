module Admin
  class BaseController < ApplicationController
    include HasCompany

    before_action :authenticate_user!
    after_action :verify_authorized
  end
end
