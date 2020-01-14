# frozen_string_literal: true

require 'rails_helper'

# Classification: External Dependency
# Success Rate: 75%
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
# In this case, we wanted to have stable http requests, I used webmock https://github.com/bblimke/webmock
# this allows us to intercept network requests and provice a stable response
# you can stub both success and failure scenarios, and prevent accident network
# requests from slipping into you spec suite.
#
# Other popular options:
# * VCR: https://github.com/vcr/vcr
# * stubbing method before the HTTP request (method stubs)
#   * I tend to avoid this when I can, stub/mock your application at it's edges
#
# flaky: bundle exec rspec spec/models/post_example_f_spec.rb
# failure: N/A
# success: N/A
RSpec.describe Post, type: :model do
  describe "post set_body" do
    before do
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

    it "expect to set body on a post without one" do
      post = Post.create!(title: Faker::String.unique.random(22).tr("\u0000", ''))
      expect { post.set_body! }.to change { post.reload.body.class }.from(NilClass).to(String)
    end
  end
end
