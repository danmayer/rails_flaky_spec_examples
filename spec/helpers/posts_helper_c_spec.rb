# frozen_string_literal: true

require 'rails_helper'

# Classification: Shared State
# Success Rate: ~50%
# Suite Required: false
RSpec.describe PostsHelper, type: :helper do
  describe "verifies generated_on_cached" do
    it "can fetch generated_on_cached" do
      travel_to "1-11-2019 14:33:20"
      expect(helper.generated_on_cached).to eq('Nov, 1, 2019')
    end

    it "generated_on_cached updates" do
      expect(helper.generated_on_cached).to eq('Nov, 1, 2019')
      travel_to 1.day.from_now
      expect(helper.generated_on_cached).to eq('Nov, 2, 2019')
    end
  end
end
