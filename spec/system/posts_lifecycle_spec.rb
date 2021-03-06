# frozen_string_literal: true

require "rails_helper"

# Classification: Race Condition
# Success Rate: ~90%
# Suite Required: false
RSpec.describe "basic posts flow", :js do
  let(:existing_post) { Post.create!(title: 'first system post', body: 'post', score: 1) }

  before do
    existing_post
  end

  context "posts" do
    it "can see index" do
      visit "/posts"
      expect(page).to have_content(/#{existing_post.title}/i)
    end

    it "can add a new post" do
      visit "/posts"
      expect(page).to have_content(/first system post/i)

      click_link "New Post"
      expect(page).to have_content(/New Post/i)

      fill_in("post[title]", with: 'second system test')
      fill_in("post[body]", with: 'post')
      fill_in("post[score]", with: '1')
      click_button "Create Post"

      expect(page).to have_content(/second system test/i)
    end

    it "can edit a post" do
      visit "/posts"
      expect(page).to have_content(/first system post/i)

      click_link "Edit", match: :first
      expect(page).to have_content(/Editing Post/i)

      fill_in("post[title]", with: 'updated system test')
      fill_in("post[body]", with: 'post')
      fill_in("post[score]", with: '1')
      click_button "Update Post"
      expect(page).to have_content(/Post was successfully updated./i)
      expect(page).to have_content(/updated system test/i)
    end
  end
end
