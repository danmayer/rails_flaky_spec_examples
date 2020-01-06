require 'rails_helper'

RSpec.describe Post, type: :model do

  before(:all) do
    @post = Post.create!(title: 'a first title', body: 'post', score: 1)
  end

  let(:another_post) { Post.create!(title: 'a second title', body: 'post', score: 1) }

  ###
  # While we have config.use_transactional_fixtures = true on, this doesn't work for
  # code in the before(:all) block... this will leave a post around after the tests
  # the first time this is run it passes if you run the tests again it it will fail
  # as there will be 3 items in the DB not 2
  #
  # reset the DB:
  # RAILS_ENV=test bundle exec rake db:drop db:create db:migrate
  # then run test which passes: bundle exec rspec spec/models/post_order_transaction_spec.rb
  # then run test agian, which fails: bundle exec rspec spec/models/post_order_transaction_spec.rb
  ###
  describe "post order" do
    it "expects results sorted by body specific order" do
      posts = [@post, another_post]
      expect(posts.map(&:title)).to eq Post.all.ordered.map(&:title)
    end
  end
end
