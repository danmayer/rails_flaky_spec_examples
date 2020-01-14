# frozen_string_literal: true

require 'rails_helper'

# Classification: Hard-coded Expectations
# Success Rate: 5%
# Suite Required: true
RSpec.describe Post, type: :model do
  let(:post) { Post.create!(title: 'without score', body: 'post') }

  describe "post find" do
    it "expect to raise when record not found" do
      expect { Post.find(1) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
