# frozen_string_literal: true

require "rails_helper"

# Classification: External Dependency
# Success Rate: ~90%
# Suite Required: false
# Example: External Dependency, any network request in your suite can and will fail sometimes
#
# Description:
# There are a number of ways to handle network requests in spec suites. I would normally also recommend
# your code path handling errors and testing both success and error conditions.
#
# The specs were flaky because of Net::ReadTimeout which would occur some percentage of the time
# how to best work with and handle timeouts is a complex topic read more here
# https://felipeelias.github.io/ruby/2017/08/20/net-http-timeouts.html
#
# Other popular options:
# * VCR: https://github.com/vcr/vcr
# * stubbing method before the HTTP request (method stubs)
#   * I tend to avoid this when I can, stub/mock your application at it's edges
#
# flaky: bundle exec rspec spec/system/post_example_b_spec.rb
# failure: N/A
# success: N/A
RSpec.describe "posts ajax fills body", :js do
  let(:existing_post) { Post.create!(title: 'first system post', body: 'post', score: 1) }

  before do
    existing_post
    # NOTE: this should really be in spec_helpers and be set for your entire test suite
    # doing so will avoid any network connections from slipping into your test suite
    WebMock.disable_net_connect!(allow_localhost: true)

    # I recommend having a spec_helper included so you can just call something like
    # stub_jsonplaceholder_post(1) from any spec, inlined for example
    stub_request(:get, "http://jsonplaceholder.typicode.com/posts/1")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '{"title": "a title"}', headers: {})

    stub_request(:get, "http://flaky-examples.free.beeceptor.com/get_text")
      .with(
        headers: {
          'Accept' => '*/*',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'User-Agent' => 'Ruby'
        }
      )
      .to_return(status: 200, body: '{"title": "a diff title"}', headers: {})
  end

  context "posts" do
    it "can see index" do
      post_count = Post.count
      visit "/posts"
      expect(page).to have_content(/#{existing_post.title}/i)
      expect(page).to have_content("total: #{post_count}")
      expect(page).to have_content("missing body: 0")

      click_button('Generate Post')
      expect(page).to have_content("total: #{(post_count + 1)}")
      expect(page).to have_content("missing body: 0")
    end
  end
end
