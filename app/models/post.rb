class Post < ApplicationRecord
  scope :ordered, -> { order(:body) }
end
