require 'rails_helper'

RSpec.describe App::EventPolicy, type: :policy do
  subject { described_class }

  let(:customer) { create(:customer) }


  before { Current.customer = customer }

  permissions :index? do
    it_behaves_like "a customer resource" do
      let(:resource) { Event }
    end
  end
end
