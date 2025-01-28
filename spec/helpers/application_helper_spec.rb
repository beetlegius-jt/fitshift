require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe 'nav_item' do
    subject { helper.nav_item(klass, path, **opts) }

    let(:path) { 'whatever' }
    let(:opts) { { class: 'some-css' } }


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

  describe 'timeago' do
    subject { helper.timeago(date, format:) }

    let(:format) { :long }

    context "when the date is empty" do
      let(:date) { "" }

      it { is_expected.to be_nil }
    end

    context "when the date is present" do
      let(:date) { Time.current }
      let(:formatted_date) { I18n.l(date, format:) }
      let(:iso8601_date) { date.iso8601 }

      it { is_expected.to include(formatted_date) }
      it { is_expected.to include('data-controller="timeago"') }
      it { is_expected.to include("data-timeago-datetime-value=\"#{iso8601_date}\"") }
    end
  end
end
