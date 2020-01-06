class Post < ApplicationRecord
  scope :ordered, -> { order(body: :asc, id: :asc) }
end
