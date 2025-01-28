require 'rails_helper'

RSpec.describe App::AgendaPolicy, type: :policy do
  let(:customer) { create(:customer) }

  subject { described_class }

  before { Current.customer = customer }

  permissions :show? do
    it_behaves_like "a customer resource" do
      let(:resource) { :agenda }
    end
  end
end
