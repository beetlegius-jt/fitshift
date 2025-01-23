module Callable
  extend ActiveSupport::Concern

  class_methods do
    def call(*, **, &)
      new(*, **).call(&)
    end
  end

  included do
    def call
      raise NotImplementedError
    end
  end
end
