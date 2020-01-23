class User < ApplicationRecord
  has_many :posts
  has_many :comments
  has_many :likes
  has_many :friendships
  has_many :reverse_friendships, class_name: 'Friendship', foreign_key: :friend_id

  devise :database_authenticatable, :registerable, :validatable, :rememberable

  validates :name, presence: true, length: { maximum: 50 }

  before_save :set_profile_image_url

  def friends
    friends_ids = friendships.where(confirmed: true).pluck(:friend_id)
    friends_ids += reverse_friendships.where(confirmed: true).pluck(:user_id)
    User.where(id: friends_ids)
  end

  def pending_friends
    pending_friends_ids = friendships.where(confirmed: false).pluck(:friend_id)
    User.where(id: pending_friends_ids)
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending_friend?(user)
    pending_friends.include?(user)
  end

  private

  def set_profile_image_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    self.profile_image_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
