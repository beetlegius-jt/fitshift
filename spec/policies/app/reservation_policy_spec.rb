require 'rails_helper'

RSpec.describe App::ReservationPolicy, type: :policy do
  subject { described_class }

  let(:customer) { create(:customer) }


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
