class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :content, presence: true

  default_scope { order(created_at: :desc) }

  def liked_by?(user)
    Like.where(post: self, user: user).any?
  end
end
