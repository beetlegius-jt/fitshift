require 'rails_helper'

RSpec.describe "Admin::Activities" do
  let(:subdomain) { "something" }
  let(:company) { create(:company, subdomain:) }
  let(:user) { create(:user, :company, owner: company) }

  before { sign_in(user) }

  it "can create an activity", :aggregate_failures do
    visit admin_root_url(subdomain:)

    within("#web-nav") do
      find("a[href='#{admin_activities_path}']").click
    end

    find("a[href='#{new_admin_activity_path}']").click

    name = "whatever name"
    duration_minutes = 45
    max_capacity = 10
    starts_on = "2025-01-15"
    utc_offset_text = "-03:00"
    utc_offset = -10800

    fill_in :activity_name, with: name
    fill_in :activity_duration_minutes, with: duration_minutes
    fill_in :activity_max_capacity, with: max_capacity

    fill_in :activity_schedule_attributes_virtual_schedule_starts_on, with: starts_on
    select utc_offset_text, from: :activity_schedule_attributes_virtual_schedule_utc_offset

    click_on I18n.t(:create, scope: "helpers.submit", model: "Activity")

    expect(page).to have_current_path(admin_activities_path)
    expect(page).to have_content I18n.t(:create, scope: :notice)

    expect(page).to have_content name
    expect(page).to have_content duration_minutes
    expect(page).to have_content max_capacity

    activity = Activity.includes(:schedule).last

    expect(activity.name).to eq(name)
    expect(activity.duration_minutes).to eq(duration_minutes)
    expect(activity.max_capacity).to eq(max_capacity)
    expect(activity.schedule.virtual_schedule.starts_on).to eq(starts_on.to_date)
    expect(activity.schedule.virtual_schedule.utc_offset).to eq(utc_offset)
  end

  it "shows errors when attempting to create an activity with invalid attributes", :aggregate_failures do
    visit admin_root_url(subdomain:)

    within("#web-nav") do
      find("a[href='#{admin_activities_path}']").click
    end

    find("a[href='#{new_admin_activity_path}']").click

    fill_in :activity_name, with: nil

    click_on I18n.t(:create, scope: "helpers.submit", model: "Activity")

    message = "Validation failed: Activity name can't be blank"

    expect(page).to have_current_path(admin_activities_path)
    expect(page).to have_content(message)
  end
end
