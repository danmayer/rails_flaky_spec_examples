require 'rails_helper'

# Classification: Randomness
# Success Rate: 80%
# Suite Required: false
RSpec.describe Post, type: :model do
  describe "post suggest_title" do
    it "expect to receive a different title suggestion" do
      post_title = Post.suggest_title
      expect(post_title).to_not eq(Post.suggest_title)
    end
  end
end
