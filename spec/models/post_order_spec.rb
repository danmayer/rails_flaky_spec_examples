require 'rails_helper'

RSpec.describe Post, type: :model do

  let(:post) { Post.create!(title: 'first title', body: 'post', score: 1) }
  let(:another_post) { Post.create!(title: 'second title', body: 'post', score: 1) }

  describe "post created" do
    # some example using post.first or post.last which assumes some DB object
    # post = Post.last
    it "expects one" do
      posts = [post]
      # Since the sort order is equal on body it will fall back to creation order
      expect(posts.map(&:title)).to eq Post.all.ordered.map(&:title)
    end

    it "expects two" do
      posts = [another_post]
      # Since the sort order is equal on body it will fall back to creation order
      expect(posts.map(&:title)).to eq Post.all.ordered.map(&:title)
    end

    it "expects results in specific order" do
      # randomly create one or the other post first
      # TODO: find a better example of ordering that doesn't use rand
      #another_post if rand(2) == 1

      posts = [post, another_post]
      # Since the sort order is equal on body it will fall back to creation order
      expect(posts.map(&:title)).to eq Post.all.ordered.map(&:title)
    end
  end
end
