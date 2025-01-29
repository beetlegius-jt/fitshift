require 'rails_helper'

RSpec.describe BootstrapIcon, type: :model do
  subject { described_class.call(name, right:, text:, **html_options) }

  let(:name) { "name" }
  let(:right) { false }
  let(:text) { nil }
  let(:html_options) { {} }

  context "when not using text" do
    let(:icon) { '<i class="bi bi-name"></i>' }

    it { is_expected.to eq(icon) }
  end

  context "when using text" do
    let(:text) { "some text" }
    let(:icon) { '<i class="bi bi-name me-1"></i>some text' }

    it { is_expected.to eq(icon) }
  end

  context "when using text and right" do
    let(:right) { true }
    let(:text) { "some text" }
    let(:icon) { 'some text<i class="bi bi-name ms-1"></i>' }

    it { is_expected.to eq(icon) }
  end

  context "when using html options" do
    let(:html_options) { { class: "some-class", something: "else" } }
    let(:icon) { '<i class="some-class bi bi-name" something="else"></i>' }

    it { is_expected.to eq(icon) }
  end
end
