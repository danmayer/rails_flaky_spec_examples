# frozen_string_literal: true

require 'rails_helper'

# Classification: Shared State
# Success Rate: 33%
# Suite Required: true
# Example: Shared State, based on other specs
#
# This is kind of a weird example... this spec itself is basically fine
# this spec fails when `post_example_c_spec` corrupts the DB state with before(:all)
# This spec run alone will always pass.
# Run as part of the suite it will pass or fail depending on if it runs before
# or after the other specs with before(:all)
#
# an alternative, way to solve this is that we don't need to be so specific in the spec
# we know set scores will add a score but not always nil -> 1, depending on the number
# of posts. So in the solution below we also just check it went from nil to not nil.
RSpec.describe Post, type: :model do
  let(:post) { Post.create!(title: 'without score', body: 'post') }

  describe "post set_scores" do
    it "expect set_scores to add scores to posts missing scores" do
      expect { Post.set_scores }.to change { post.reload.score }.from(NilClass).to(Integer)
    end
  end
end
