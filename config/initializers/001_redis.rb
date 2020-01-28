# frozen_string_literal: true

redis_url = ENV['REDIS_URL']
REDIS = Redis.new(url: redis_url)
