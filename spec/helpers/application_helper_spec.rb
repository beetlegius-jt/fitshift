require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'nav_item' do
    let(:path) { 'whatever' }
    let(:opts) { { class: 'some-css' } }

    subject { helper.nav_item(klass, path, **opts) }

    context 'when using a klass' do
      let(:klass) { Company }
      let(:link) { '<li class="nav-item me-4"><a class="some-css" href="whatever">Companies</a></li>' }

      it { is_expected.to eq(link) }
    end

    context 'when using an anchor' do
      let(:klass) { "something" }
      let(:link) { '<li class="nav-item me-4"><a class="some-css" href="whatever">something</a></li>' }

      it { is_expected.to eq(link) }
    end
  end
end
