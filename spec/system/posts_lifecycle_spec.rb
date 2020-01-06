require "rails_helper"

RSpec.describe "basic posts flow", :js do
  before do
    @existing_post = Post.create!(title: 'first system post', body: 'post', score: 1)
  end

  context "posts" do

    it "can see index" do
      visit "/posts"
      expect(page).to have_content(/first system post/i)
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
