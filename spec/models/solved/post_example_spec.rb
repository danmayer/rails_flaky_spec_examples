require 'rails_helper'

# Classification: Shared State, Order Dependency
# Success Rate: 99%
# Suite Required: true
# Example: Shared DB State, suite order dependency
#
# Description:
# Specs in this file make the assumption that the post ID will never be 1.
# This is not true, in the case of id sequence on a brand new DB, & this spec runs first.
# This means this spec would only fail on systems with a clean DB (often CI), and when this spec is the very first
# spec to run.
#
# flaky:
# bundle exec rspec
# failure:
# bundle exec rake db:drop db:create db:migrate
# bundle exec rspec spec/models/post_example_spec.rb
# success: N/A
RSpec.describe Post, type: :model do

  let(:post) { Post.create!(title: 'first', body: 'post', score: 1) }

  describe "post created" do
    it "can be updated without changing the ID" do
      post.update!(title: 'updated')
      expect(post.id).to_not eq 1
    end
  end
end
