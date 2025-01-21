require 'rails_helper'

RSpec.describe "Admin::Companies", type: :system do
  let(:subdomain) { "something" }
  let(:company) { create(:company, subdomain:) }
  let(:user) { create(:user, :company, owner: company) }

  before { sign_in(user) }

  it "can update the company configuration" do
    visit admin_root_url(subdomain:)

    within("#web-nav") do
      find("a[href='#{edit_admin_company_path}']").click
    end

    new_name = "whatever name"
    new_subdomain = "whatever-subdomain"

    fill_in :company_name, with: new_name
    fill_in :company_subdomain, with: new_subdomain

    click_button I18n.t(:update, scope: "helpers.submit")

    expect(page).to have_current_path(edit_admin_company_path)
    expect(page).to have_content I18n.t(:update, scope: :notice)

    company.reload

    expect(company.name).to eq(new_name)
    expect(company.subdomain).to eq(new_subdomain)
  end

  it "shows errors when attempting to update a company with invalid attributes" do
    visit admin_root_url(subdomain:)

    within("#web-nav") do
      find("a[href='#{edit_admin_company_path}']").click
    end

    fill_in :company_name, with: nil

    click_button I18n.t(:update, scope: "helpers.submit")

    message = "Validation failed: Company name can't be blank"

    expect(page).to have_current_path(admin_company_path)
    expect(page).to have_content(message)

    expect(company.reload.name).to be_present
  end
end
