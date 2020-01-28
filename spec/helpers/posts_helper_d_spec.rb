# frozen_string_literal: true

require 'rails_helper'

# Classification: Shared State
# Success Rate: ~50%
# Suite Required: false
RSpec.describe PostsHelper, type: :helper do
  describe "verifies hits counter" do
    it "can fetch counter" do
      expect(helper.hits_counter).to eq('1')
    end

    it "can increament_counter" do
      helper.increament_hits
      expect(helper.hits_counter).to eq('2')
    end
  end
end
