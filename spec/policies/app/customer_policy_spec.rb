require 'rails_helper'

RSpec.describe App::CustomerPolicy, type: :policy do
  subject { described_class }

  let(:customer) { build(:customer) }


  before { Current.customer = customer }

  permissions :show? do
    it_behaves_like "a customer resource" do
      let(:resource) { customer }
    end
  end
end
