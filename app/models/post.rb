class Post < ApplicationRecord
  validates :title, uniqueness: true

  scope :ordered, -> { order(body: :asc, id: :asc) }

  before_create :set_expires_at

  private

  def set_expires_at
    self.expires_at ||= Time.now + 2.days
  end
end
