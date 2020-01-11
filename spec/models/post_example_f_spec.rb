# frozen_string_literal: true

require 'rails_helper'

# Classification: External Dependency
# Success Rate: 75%
# Suite Required: false
RSpec.describe Post, type: :model do
  describe "post pull_body" do
    it "expect to set body on posts without one" do
      post = Post.create!(title: Faker::String.unique.random(22).tr("\u0000", ''))
      expect { Post.set_body }.to change { post.reload.body.class }.from(NilClass).to(String)
    end
  end
end
