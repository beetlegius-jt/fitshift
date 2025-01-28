require 'rails_helper'

RSpec.describe App::EventPolicy, type: :policy do
  let(:customer) { create(:customer) }

  subject { described_class }

  before { Current.customer = customer }

  permissions :index? do
    it_behaves_like "a customer resource" do
      let(:resource) { Event }
    end
  end
end
