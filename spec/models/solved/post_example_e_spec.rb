require 'rails_helper'

# Classification: Randomness
# Success Rate: 80%
# Suite Required: false
# Example: Randomness, poor faker usage, https://github.com/faker-ruby/faker
#
# Description:
# When purposefully using randomness in specs, be careful...
#   * does it really need to be random?
#   * should you make it deterministically random? (based off rspec seed)
#
# In this case since we only need truly uniqueness, we moved to:
# Faker::String.unique.random(2) which faker guarantees will be unique
# so long as it doesn't run out of options, some of its collections have small sets
#
# flaky: bundle exec rspec spec/models/post_example_e_spec.rb
# failure: N/A
# success: N/A
RSpec.describe Post, type: :model do
  describe "post ordered" do
    it "expect many order posts to be in alphabetical order" do
      alphabet = ('a'..'z').to_a
      alphabet.each { |el| Post.create!(title: Faker::String.unique.random(2), body: el) }
      expect(Post.ordered.map(&:body)).to eq(alphabet)
    end
  end
end
