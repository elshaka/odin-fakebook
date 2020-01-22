class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :friendships
  has_many :friends, through: :friendships, class_name: 'User'
  has_many :reverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
  has_many :reverse_friends, through: :reverse_friendships, source: :user

  devise :database_authenticatable, :registerable, :validatable, :rememberable

  validates :name, presence: true, length: { maximum: 50 }

  before_save :set_profile_image_url

  private

  def set_profile_image_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    self.profile_image_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
