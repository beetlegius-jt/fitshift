module App
  class AgendaPolicy < ApplicationPolicy
    def show?
      customer?
    end
  end
end
