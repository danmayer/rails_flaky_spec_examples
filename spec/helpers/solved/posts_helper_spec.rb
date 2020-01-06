require 'rails_helper'

# Classification: Shared State
# Success Rate: ~50%
# Example: Shared Class Variable State, in file test order dependency
#
# Description:
# Specs in this file have access to a helper object that includes
# a class based variable counter. The tests when run will pass or fail depending
# on the order they are run. This is because calling `helper.increament_counter(2)` modifies
# the class state.
#
# flaky: bundle exec rspec spec/helpers/posts_helper_spec.rb
# failure: bundle exec rspec spec/helpers/posts_helper_spec.rb --seed 52493
# success: bundle exec rspec spec/helpers/posts_helper_spec.rb --seed 52496
RSpec.describe PostsHelper, type: :helper do
  describe "verifies counter" do
    # If you really want to test the accessor isolated, don't compare to default value
    # instead compare to current value, honestly I would just remove this spec
    it "can fetch counter" do
      expect(helper.get_counter).to eq(helper.class.class_variable_get(:@@bad_class_counter))
    end

    it "can increament_counter" do
      expect { helper.increament_counter(2) }.to change { helper.get_counter }.by(2)
    end
  end
end
