require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:conflicting_post) { Post.create!(title: 'my title', body: 'post', score: 1) }

  ###
  # This spec run alone will always pass.
  # Run as part of the suite it will pass or fail depending on if it runs first
  # or second related to post_order_across_file_two_spec
  ###
  describe "post can be modified" do
    it "expects results sorted by body specific order" do
      conflicting_post.update!(title: 'a updated title')
      expect(conflicting_post.title).to eq 'a updated title'
    end
  end
end
