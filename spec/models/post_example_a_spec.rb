# frozen_string_literal: true

require 'rails_helper'

# Classification: Shared State, Order Dependency
# Success Rate: 99%
# Suite Required: true
RSpec.describe Post, type: :model do
  let(:post) { Post.create!(title: 'first', body: 'post', score: 1) }

  describe "post created" do
    it "can be updated without changing the ID" do
      expect(post.id).to eq 1
      post.update!(title: 'updated')
      expect(post.id).to eq 1
    end
  end
end
