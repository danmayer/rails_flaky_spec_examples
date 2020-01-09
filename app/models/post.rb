class Post < ApplicationRecord
  validates :title, uniqueness: true

  scope :ordered, -> { order(body: :asc, id: :asc) }

  before_create :set_expires_at

  def self.set_scores
    Post.where(score: nil).each_with_index do |post, index|
      post.update!(score: (index + 1))
    end
  end

  private

  def set_expires_at
    self.expires_at ||= Time.now + 2.days
  end
end
