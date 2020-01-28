# frozen_string_literal: true

module PostsHelper
  ###
  # This is a bad example of a helper file / methods, but it isn't uncommon to have
  # class variable based caches, initilized on boot in Rails.
  # These class vars, can lead to common testing gotchas.
  #
  # This kind of error is also common with caches / key value stories like redis
  ###
  @@bad_class_counter = 1

  def get_counter
    @@bad_class_counter
  end

  def increament_counter(val)
    @@bad_class_counter += val
  end

  PAGE_HITS_KEY = 'PAGE_HITS_KEY_v1'
  def hits_counter
    REDIS.get(PAGE_HITS_KEY) || (increament_hits && '1')
  end

  def increament_hits
    REDIS.incr(PAGE_HITS_KEY)
  end

  def generated_on
    Time.current.strftime("%b, %-d, %Y")
  end

  def generated_on_cached
    Rails.cache.fetch("generated_on_cached", expires_in: 1.day) do
      generated_on
    end
  end
end
