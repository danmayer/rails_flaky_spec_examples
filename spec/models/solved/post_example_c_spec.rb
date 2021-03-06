# frozen_string_literal: true

require 'rails_helper'

# Classification: Shared State
# Success Rate: 50%
# Suite Required: true
# Example: Shared State, based on before(:all)
#
# Description:
# Before all runs outside of transactions. If you are using transactions for your
# specs, you will now be in a world of hurt... This spec alone will always pass
# but it will break other specs depending on if this runs before or after them.
#
# Basically, `before(:all)`` is bad don't do it.
# https://makandracards.com/makandra/11507-using-before-all-in-rspec-will-cause-you-lots-of-trouble-unless-you-know-what-you-are-doing
#
# 'rubocop-rspec' will give an error for using before(:all), I disabled that cop so
# I could show an example, but it really should be avoided, and rubocop-rspec can help
# ensure usage doesn't slip in
#
# flaky: bundle exec rspec
# failure: N/A
# success: N/A
RSpec.describe Post, type: :model do
  let(:post) { Post.create_or_find_by!(title: 'my title', body: 'post') }

  # This spec never really had any reason to use before(:all) and switching to before works.
  # Honestly, with a single example just using let is good enough... but trying to highlight
  # use before, not before(:all)
  before do
    post
  end

  describe "post can be modified" do
    it "expects to be able to update a post" do
      post.update!(title: 'a updated title')
      expect(post.title).to eq 'a updated title'
    end
  end
end
