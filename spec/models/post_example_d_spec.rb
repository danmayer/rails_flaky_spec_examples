# frozen_string_literal: true

require 'rails_helper'

# Classification: Shared State
# Success Rate: 90%
# Suite Required: true
RSpec.describe Post, type: :model do
  let(:post) { Post.create!(title: 'yet another title', body: 'post') }

  describe "post set_scores" do
    it "expect set_scores to add scores to posts missing scores" do
      expect { Post.set_scores }.to change { post.reload.score }.from(nil).to(1)
    end
  end
end
