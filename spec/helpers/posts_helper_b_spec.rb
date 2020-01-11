# frozen_string_literal: true

require 'rails_helper'

# Classification: Time
# Success Rate: ~75%
# Suite Required: false
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
      expect(helper.generated_on).to match(/, 2019/)
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
