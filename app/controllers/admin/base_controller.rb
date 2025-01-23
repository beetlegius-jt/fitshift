module Admin
  class BaseController < ApplicationController
    include HasCurrentAttributes
    include ErrorHandler
    include ActionView::RecordIdentifier

    before_action :authenticate_user!
    after_action :verify_authorized

    def policy_scope(scope)
      super([ :admin, scope ])
    end

    def authorize(record, query = nil)
      super([ :admin, record ], query)
    end
  end
end
