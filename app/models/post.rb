# frozen_string_literal: true

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
    Post.where(body: nil).each_with_index do |post, _index|
      post.set_body!
    end
  end

  def set_body!
    update!(body: self.class.pull_body)
  end

  def self.generate!
    body = begin
             pull_body
           rescue StandardError
             nil
           end
    Post.create!(title: "generated #{SecureRandom.uuid}", body: body)
  end

  TITLES = ['cow says moo', 'title one', 'funny title', 'this is barely random']
  def self.suggest_title
    TITLES.sample
  end

  private

  ###
  # This method is to exercise hitting external network requests
  # to not overload free providers we randomly switch between a few
  # each has some different options / results
  ###
  def self.pull_body
    # NOTE: __DO NOT SOLVE__ Flaky Specs by removing this rand
    # this rand is to help send different network errors
    # and success randomly
    if rand(7) > 1
      body_from_json_placeholder
    else
      body_from_json_beeceptor
    end
  end

  def self.body_from_json_placeholder
    url = URI.parse('http://jsonplaceholder.typicode.com/posts/1')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port, open_timeout: 3, read_timeout: 3) do |http|
      http.request(req)
    end
    JSON.parse(res.body)['title']
  end

  def self.body_from_json_beeceptor
    url = URI.parse('http://flaky-examples.free.beeceptor.com/get_text')
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port, open_timeout: 3, read_timeout: 3) do |http|
      http.request(req)
    end
    JSON.parse(res.body)['title']
  end

  def set_expires_at
    self.expires_at ||= Time.current + 2.days
  end
end
