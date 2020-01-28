# frozen_string_literal: true

require 'rails_helper'

# Classification: Shared State
# Success Rate: ~50%
# Suite Required: false
# Example: Shared Redis State, in file test 'Order' dependency
#
# Description:
# Specs in this file have access to a helper object which uses redis
# much like the database one needs to ensure that between tests
# the redis state is reset, or alternatively, one could try to write tests that
# don't make assumptions on the current state.
RSpec.describe PostsHelper, type: :helper do
  describe "verifies hits counter" do
    # NOTE: Often it is better to put this in spec_helper around all specs
    # but it depends, if only a small subset of code is interacting with a given cache
    before do
      Rails.cache.clear
    end

    # NOTE: honestly, I would just remove this spec, and only leave the increament
    # which exercised both methods
    it "can fetch counter" do
      expect(helper.hits_counter).to_not be_nil
    end

    it "can increament_counter" do
      expect { helper.increament_hits }.to change { helper.hits_counter.to_i }.by(1)
    end
  end
end
