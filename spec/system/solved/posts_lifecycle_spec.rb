# frozen_string_literal: true

require "rails_helper"

# Classification: Race Condition
# Success Rate: ~70%
# Suite Required: false
# Example: Race Condition with JS Animations vs Capybara.default_max_wait_time (which defaults to 2s)
#
# Description:
# Specs in this file run JS!
# Once you are running JS things are happening async in the browser that can cause Time issues
#
# There MANY ways to solve this issue... We can document a few solutions
#
# * increase the time Capybara can wait for actions to complete
#     * in spec_helper set, `Capybara.default_max_wait_time = 5`
#     * this is the easiest, but over time will keep making your test suite slower
# * disable JQuery animations
#     * that is the solution implemented here, see
#     * see JS injected in `application.html.erb` for solved specs `<%= javascript_tag '$.fx.off = true;' if ENV['SOLVED_SPECS'] %>`
#     * more details https://makandracards.com/coffeeandcode/7503-disable-jquery-animations-during-rails-tests
# * disable all CSS animations and transitions
#     * see details here: https://stackoverflow.com/questions/19662287/turn-off-animations-in-capybara-tests
#
# flaky: bundle exec rspec spec/system/posts_lifecycle_spec.rb
# failure: N/A, hilariously since it is a race condition, play a video it will slow down and fail
# success: bundle exec rspec --tag solved spec/system/solved/posts_lifecycle_spec.rb
#
# NOTE: ALL of the specs in this file are the same, but the solved meta data and ENV
# are applied which results in the JS being fixed in the app code.
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
