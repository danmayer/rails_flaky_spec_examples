module PostsHelper

  ###
  # This is a bad example of a helper file / methods, but it isn't uncommon to have
  # class variable based caches, initilized on boot in Rails.
  # These class vars, can lead to common testing gotchas
  ###
  @@bad_class_counter = 1

  def get_counter
    @@bad_class_counter
  end

  def increament_counter(val)
    @@bad_class_counter += val
  end
end
