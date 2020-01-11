# frozen_string_literal: true

require "rails_helper"

# Classification: External Dependency
# Success Rate: ~90%
# Suite Required: false
RSpec.describe "posts ajax fills body", :js do
  before do
    @existing_post = Post.create!(title: 'first system post', body: 'post', score: 1)
  end

  context "posts" do
    it "can see index" do
      post_count = Post.count
      visit "/posts"
      expect(page).to have_content(/#{@existing_post.title}/i)
      expect(page).to have_content("total: #{post_count}")
      expect(page).to have_content("missing body: 0")

      click_button('Generate Post')
      expect(page).to have_content("total: #{(post_count + 1)}")
      expect(page).to have_content("missing body: 0")
    end
  end
end
