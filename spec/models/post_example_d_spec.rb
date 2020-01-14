# frozen_string_literal: true

require 'rails_helper'

# Classification: Shared State
# Success Rate: 50%
# Suite Required: true
RSpec.describe Post, type: :model do
  before(:all) do
    @post = Post.create_or_find_by!(title: 'my title', body: 'post')
  end

  describe "existing post can be modified" do
    it "expects to be able to update a post" do
      @post.update!(title: 'a updated title')
      expect(@post.title).to eq 'a updated title'
    end
  end
end
