require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:post) { Post.create!(title: 'first', body: 'post', score: 1) }

  # This spec passes when run alone, or if it happens to be the very first spec of the suite
  describe "post created" do
    it "can be updated" do
      post.update!(title: 'updated')
      expect(post.id).to eq 1
    end
  end
end
