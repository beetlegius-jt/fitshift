require 'rails_helper'

RSpec.describe App::CustomerPolicy, type: :policy do
  let(:customer) { build(:customer) }

  subject { described_class }

  before { Current.customer = customer }

  permissions :show? do
    it_behaves_like "a customer resource" do
      let(:resource) { customer }
    end
  end
end
