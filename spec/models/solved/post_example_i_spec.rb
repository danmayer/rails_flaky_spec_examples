# frozen_string_literal: true

require 'rails_helper'

# Classification: Hard-coded Expectations
# Success Rate: 5%
# Suite Required: true
# Example: Hard-coded Expectations, and kind of Shared State, based on other specs
#
# This is example will pass so long as there isn't some post with ID 1 in the DB
# this fails if you had fixtures, before(:all), or something else populate the DB
# prior to this test...
#
# More often you will see some crazy fake ID, like 42, 9999, 1234, etc but given
# how sequencing works any ID can and will get hit randomly in your spec suite.
#
# Solution: We solved in this case by using -1 which for all DBs I am aware of, is an invalid
# sequence ID and will always fail to find a record.
RSpec.describe Post, type: :model do
  let(:post) { Post.create!(title: 'without score', body: 'post') }

  describe "post find" do
    it "expect to raise when record not found" do
      expect { Post.find(-1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
