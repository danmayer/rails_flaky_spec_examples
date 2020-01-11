# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  # Classification: Time
  # Success Rate: 80%
  # Suite Required: false
  describe "post created" do
    it "has expected default expires_at" do
      simulate_test_running_on_different_days
      post = Post.create!(title: 'another title', body: 'post', score: 1)
      expect(post.expires_at.to_json).to eq 48.hours.from_now.to_json
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
