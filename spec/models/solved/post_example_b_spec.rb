# frozen_string_literal: true

require 'rails_helper'

# Classification: Time
# Success Rate: 80%
# Suite Required: false
# Example: Time Error, based on the time and date the spec is run
#
# Description:
# Specs in this file depend on the system time, while this is a simplified example
# this was extracted from a real world project, where an upstream service used 48.hours
# and the client service used 2.days in the tests. The tests failed only around DST changes.
#
# flaky: bundle exec rspec spec/models/post_example_b_spec.rb
# failure: SPEC_DATE='02-11-2019 14:33:20' bundle exec rspec spec/models/post_example_b_spec.rb
# success: SPEC_DATE='02-10-2019 14:33:20' bundle exec rspec spec/models/post_example_b_spec.rb
RSpec.describe Post, type: :model do
  describe "post created" do
    it "has expected default expires_at" do
      simulate_test_running_on_different_days
      post = Post.create!(title: 'another title', body: 'post', score: 1)
      # NOTE: This spec now passes all the time because we use `2.days.from_now` both in the model
      # and in the spec, previously the spec used `48.hours.from_now`
      # when the spec is run during daylight savings time
      # 2.days and 48.hours are not the same...
      #
      # Did you really intend for a user to have something expire in 47 hours during
      # daylight savings time?
      # Depending on business use case the biz requirements could actually be different.
      # One should try to ensure their test matches the code logic, but also the real
      # business intentions.
      expect(post.expires_at.to_json).to eq 2.days.from_now.to_json
    end

    # NOTE: This 'flaky' spec isn't teaching about failures due to randomness or travel_to
    # randomness along with travel_to is to simulate the test running on different days.
    # A logic mismatch exists and should not be fixed by removing rand or travel_to
    # DO NOT REMOVE: `rand` or `travel_to` to 'solve' this spec
    def simulate_test_running_on_different_days
      travel_to Time.parse(ENV['SPEC_DATE'] || "#{rand(1..5)}-11-2019 14:33:20'")
    end
  end
end
