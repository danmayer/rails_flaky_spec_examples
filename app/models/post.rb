class Post < ApplicationRecord
  validates :title, uniqueness: true

  scope :ordered, -> { order(body: :asc, id: :asc) }
end
