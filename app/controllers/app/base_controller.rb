module App
  class BaseController < ApplicationController
    prepend_before_action :authenticate_user!
    before_action :protect
    after_action :verify_authorized

    def policy_scope(scope)
      super([ :app, scope ])
    end

    def authorize(record, query = nil)
      super([ :app, record ], query)
    end

    private

    def protect
      redirect_to admin_root_path unless Current.user.customer?
    end
  end
end
