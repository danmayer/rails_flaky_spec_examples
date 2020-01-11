# frozen_string_literal: true

require 'rails_helper'

# Classification: Time
# Success Rate: ~75%
# Suite Required: false
# Example: Time, As the time comes close to the new year, this will fail
#
# Description:
# Specs in this file are trying to test time changing verifying a change over time.
# It is very common to use time_travel or timecop in specs, but you still have to be careful
# with timezones, daylight savings time, new year, month boundaries, leap year, etc
#
# In this case we solve the issue by not hard coding a year, but using a dynamically
# calculated current year. Even though we used travel_to we can't assume a hard coded date
# because we are trying to add time with `1.week.from_now` which could cross various
# boundaries (daylight savings time or new year for example).
#
# flaky: bundle exec rspec spec/helpers/posts_helper_b_spec.rb
# failure: N/A
# success: N/A
RSpec.describe PostsHelper, type: :helper do
  describe "generated_on" do
    it "shows date" do
      simulate_test_running_on_different_days
      expect(helper.generated_on).to match(/, 2019/)
    end

    it "dynamically moves forward with time" do
      simulate_test_running_on_different_days
      expect(helper.generated_on).to match(/, 2019/)
      travel_to 1.week.from_now
      current_year = Time.current.year
      expect(helper.generated_on).to match(/, #{current_year}/)
    end
  end

  # NOTE: This 'flaky' spec isn't teaching about failures due to randomness or travel_to
  # randomness along with travel_to is to simulate the test running on different days.
  # A logic mismatch exists and should not be fixed by removing rand or travel_to
  # DO NOT REMOVE: `rand` or `travel_to` to 'solve' this spec
  def simulate_test_running_on_different_days
    travel_to Time.parse(ENV['SPEC_DATE'] || "26-#{rand(9..12)}-2019 14:33:20'")
  end
end
