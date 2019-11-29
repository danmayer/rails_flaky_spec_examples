require 'rails_helper'

# Example: Shared Class Variable State, Test Order dependency
#
#
# Specs in this file have access to a helper object that includes
# a class based variable counter. The tests when run will pass or fail depending
# on the order they are run. In this example it should fail 50% of the time.
#
# flaky: bundle exec rspec spec/helpers/posts_helper_spec.rb
# failure: bundle exec rspec spec/helpers/posts_helper_spec.rb --seed 52493
# success: bundle exec rspec spec/helpers/posts_helper_spec.rb --seed 52496
RSpec.describe PostsHelper, type: :helper do
  describe "checks class state" do

    # This spec will pass if this test runs first
    it "can fetch counter" do
      expect(helper.get_counter).to eq(1)
    end

    # This spec changes the state and class variable value for all tests
    # that follow it in execution order.
    it "can increament_counter" do
      expect(helper.get_counter).to eq(1)
      helper.increament_counter(2)
      expect(helper.get_counter).to eq(3)
    end
  end
end
