# frozen_string_literal: true

require 'rails_helper'

# Classification: Shared State
# Success Rate: 90%
# Suite Required: true
# Example: Shared State, based on other specs
#
# Description:
# This is kind of a weird example... This spec itself is 'technically' fine.
# That beinf said, it is easy to improve, by having a less general failing filter value
# which is how it is 'solved' here.
#
# This spec fails when `post_example_c_spec` corrupts the DB state with before(:all)
#
# flaky: bundle exec rspec
# failure: N/A
# success: bundle exec rspec spec/requests/posts_spec.rb
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
      get posts_path(filter: 'post_filt')
      expect(response).to have_http_status(200)
      expect(response.body).to include("No posts found")
    end
  end
end
