require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "post created" do
    it "creates expected attributes" do
      post = Post.create!(title: 'first', body: 'post', score: 1)
      expect('first').to eq post.title
    end

    # currently flaky based on random date
    # always passes: SPEC_DATE='02-10-2019 14:33:20' bundle exec rspec spec/models/post_spec.rb
    # always fails : SPEC_DATE='02-11-2019 14:33:20' bundle exec rspec spec/models/post_spec.rb
    it "can have confusing time test issues" do
      # NOTE: This spec passes in all cases when in UTC
      # but wouldn't when interacting with code that sets users timezones
      Time.zone = 'Pacific Time (US & Canada)'
      travel_to Time.parse(ENV['SPEC_DATE'] || "#{rand(10)}-11-2019 14:33:20'")
      post = Post.create!(title: 'first', body: 'post', score: 1, expires_at: Time.now + 48.hours)
      # This passes regardless of DST, but might not be the date you expect depending on use case
      expect(48.hours.from_now.to_json).to eq post.expires_at.to_json
      # This fails when within 48 hours of daylight savings time
      expect(2.days.from_now.to_json).to eq post.expires_at.to_json
    end
  end

  ###
  # How to make bad data persist with functional transactional fixtures
  ###
  # describe "post can be updated" do
  #   it "returns a success response" do
  #     post = Post.last
  #     post.update(title: 'updated')
  #     expect('updated').to eq post.title
  #   end
  # end
end
