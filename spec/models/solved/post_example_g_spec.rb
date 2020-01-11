require 'rails_helper'

# Classification: Randomness
# Success Rate: 80%
# Suite Required: false
# Example: Randomness, spec directly checking sampled results
#
# Description:
# When purposefully using randomness in specs, be careful...
#   * does it really need to be random?
#   * should you make it deterministically random? (based off rspec seed)
#   * Does your test need to know it is random? Or just that it meets some expectation
#
# In this case since there are many options to solve we are just picking a random suggestion.
# I have included two solutions below:
#
# * stub the random method to provide deterministic results (stub sample)
# * validate the result is included in the samle set
#
# flaky: bundle exec rspec spec/models/post_example_g_spec.rb
# failure: N/A
# success: N/A
RSpec.describe Post, type: :model do
  describe "post suggest_title" do
    context "solution 1 stubbing" do
      before do
        allow_any_instance_of(Array).to receive(:sample).and_return('first', 'second')
      end

      it "expect to receive a different title suggestion" do
        post_title = Post.suggest_title
        expect(post_title).to_not eq(Post.suggest_title)
      end
    end

    context "solution 2 check matches group" do
      it "expect to receive a different title suggestion" do
        post_title = Post.suggest_title
        expect(Post::TITLES).to include(post_title)
      end
    end
  end
end
