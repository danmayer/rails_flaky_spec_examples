require 'rails_helper'

RSpec.describe Post, type: :model do

  before(:all) do
    @conflicting_post = Post.create!(title: 'my title', body: 'post', score: 1)
  end

  after(:all) do
    Post.destroy_all
  end

  ###
  # This spec run alone will always pass.
  # Run as part of the suite it will pass or fail depending on if it runs first
  # or second related to post_order_across_file_two_spec
  # note: basically before(:all) is bad don't do it
  # https://makandracards.com/makandra/11507-using-before-all-in-rspec-will-cause-you-lots-of-trouble-unless-you-know-what-you-are-doing
  ###
  describe "post can be modified" do
    it "expects results sorted by body specific order" do
      @conflicting_post.update!(title: 'a updated title')
      expect(@conflicting_post.title).to eq 'a updated title'
    end
  end
end