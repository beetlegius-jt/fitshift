require 'rails_helper'

RSpec.describe "Admin::Attendances", type: :system do
  let(:subdomain) { "something" }
  let(:company) { create(:company, subdomain:) }
  let(:user) { create(:user, :company, owner: company) }

  before { sign_in(user) }

  let!(:attendance) { create(:attendance, company:) }

  it "can list all and delete the attendances" do
    visit admin_root_url(subdomain:)

    within("#web-nav") do
      find("a[href='#{admin_attendances_path}']").click
    end

    expect(page).to have_content attendance.customer.name
    expect(page).to have_content I18n.l(attendance.attended_at)

    within("##{dom_id(attendance)}") { click_on I18n.t(:delete) }

    expect(page).not_to have_content attendance.customer.name
    expect(page).not_to have_content I18n.l(attendance.attended_at)
  end
end
