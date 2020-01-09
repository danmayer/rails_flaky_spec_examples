require 'rails_helper'

# Classification: Shared State
# Success Rate: 90%
# Suite Required: true
RSpec.describe Post, type: :model do

  before(:all) do
    @post = Post.create_or_find_by!(title: 'my title', body: 'post')
  end

  describe "post can be modified" do
    it "expects to be able to update a post" do
      @post.update!(title: 'a updated title')
      expect(@post.title).to eq 'a updated title'
    end
  end
end
