require 'rails_helper'

RSpec.describe App::ReservationPolicy, type: :policy do
  let(:customer) { create(:customer) }

  subject { described_class }

  before { Current.customer = customer }

  permissions :index?, :create? do
    it_behaves_like "a customer resource" do
      let(:resource) { Reservation }
    end
  end

  permissions :show?, :destroy? do
    it_behaves_like "a customer resource" do
      let(:resource) { build(:reservation, customer:) }
    end
  end
end
