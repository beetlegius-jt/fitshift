require 'rails_helper'

RSpec.describe "Admin::Attendances" do
  let(:subdomain) { "something" }
  let!(:attendance) { create(:attendance, company:) }
  let(:company) { create(:company, subdomain:) }
  let(:user) { create(:user, :company, owner: company) }

  before { sign_in(user) }


  it "can list all and delete the attendances", :aggregate_failures do
    visit admin_root_url(subdomain:)

    within("#web-nav") do
      find("a[href='#{admin_attendances_path}']").click
    end

    formatted_attended_at = I18n.l(attendance.attended_at.in_time_zone(company.utc_offset))

    expect(page).to have_content attendance.customer.name
    expect(page).to have_content formatted_attended_at

    within("##{dom_id(attendance)}") { click_on I18n.t(:delete) }

    expect(page).to have_no_content attendance.customer.name
    expect(page).to have_no_content formatted_attended_at
  end
end
