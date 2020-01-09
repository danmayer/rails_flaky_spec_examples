require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do
    before do
      Post.create!(title: 'yet another title', body: 'post_filter')
    end

    it "exact match filtering supported" do
      get posts_path(filter: 'post_filter')
      expect(response).to have_http_status(200)
      expect(response.body).to include("post_filter")
    end

    it "partial match filtering not supported" do
      get posts_path(filter: 'post')
      expect(response).to have_http_status(200)
      expect(response.body).to include("No posts found")
    end
  end
end
