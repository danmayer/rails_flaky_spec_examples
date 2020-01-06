require 'rails_helper'

# Classification: Shared State
# Success Rate: ~50%
# Suite Required: false
RSpec.describe PostsHelper, type: :helper do
  describe "verifies counter" do
    it "can fetch counter" do
      expect(helper.get_counter).to eq(1)
    end

    it "can increament_counter" do
      expect(helper.get_counter).to eq(1)
      helper.increament_counter(2)
      expect(helper.get_counter).to eq(3)
    end
  end
end
