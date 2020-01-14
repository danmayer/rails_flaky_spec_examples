# frozen_string_literal: true

require 'rails_helper'

# Classification: Shared State
# Success Rate: ~50%
# Suite Required: false
# Example: Shared Rails.cache State, in file test 'Order' dependency
#
# Description:
# Specs in this file have access to a helper object that uses Rails.cache
# depending on the order the tests are run, the cache will get set to today's date
# or the whatever the spec traveled_to. Also, in this case we might not need a specific date
# we could check for change over time. It is good practice to clear the `Rails.cache` between tests
#
# Solution: move travel_to into a before, clear Rails cache after each example.
# This avoids one spec results being cached impacting the other.
#
# flaky: bundle exec rspec spec/helpers/posts_c_helper_spec.rb
RSpec.describe PostsHelper, type: :helper do
  before do
    travel_to "1-11-2019 14:33:20"
  end

  # NOTE: Often it is better to put this in spec_helper around all specs
  # but it depends, if you are good about not using cache in tests it might not
  # be needed
  after do
    Rails.cache.clear
  end

  describe "verifies generated_on_cached" do
    it "can fetch generated_on_cached" do
      expect(helper.generated_on_cached).to eq('Nov, 1, 2019')
    end

    it "generated_on_cached updates" do
      day = Time.current.day
      expect(helper.generated_on_cached).to eq("Nov, #{day}, 2019")
      travel_to 1.day.from_now
      expect(helper.generated_on_cached).to eq("Nov, #{day + 1}, 2019")
    end
  end
end
