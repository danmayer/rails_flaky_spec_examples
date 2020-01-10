require 'net/http'
require 'securerandom'

class Post < ApplicationRecord
  validates :title, uniqueness: true

  scope :ordered, -> { order(body: :asc, id: :asc) }

  before_create :set_expires_at

  def self.set_scores
    Post.where(score: nil).each_with_index do |post, index|
      post.update!(score: (index + 1))
    end
  end

  def self.set_body
    Post.where(body: nil).each_with_index do |post, index|
      post.update!(body: pull_body)
    end
  end

  def self.generate!
    body = pull_body rescue nil
    Post.create!(title: "generated #{SecureRandom.uuid}", body: body)
  end

  private

  ###
  # This method is to exercise hitting external network requests
  # to not overload free providers we randomly switch between a few
  # each has some different options / results
  ###
  def self.pull_body
    if rand(7) > 1
      body_from_json_placeholder
    else
      body_from_json_beeceptor
    end
  end

  def self.body_from_json_placeholder
    url = URI.parse('http://jsonplaceholder.typicode.com/posts/1')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port, :open_timeout => 3, :read_timeout => 3) {|http|
      http.request(req)
    }
    JSON.parse(res.body)['title']
  end

  def self.body_from_json_beeceptor
    url = URI.parse('http://flaky-examples.free.beeceptor.com/get_text')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port, :open_timeout => 3, :read_timeout => 3) {|http|
      http.request(req)
    }
    JSON.parse(res.body)['title']
  end

  def set_expires_at
    self.expires_at ||= Time.now + 2.days
  end
end
