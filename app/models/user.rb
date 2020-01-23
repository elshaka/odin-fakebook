class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :reverse_friendships, class_name: 'Friendship', foreign_key: :friend_id, dependent: :destroy

  devise :database_authenticatable, :registerable, :validatable, :rememberable

  validates :name, presence: true, length: { maximum: 50 }

  before_save :set_profile_image_url

  def friends
    friends_ids = friendships.where(confirmed: true).pluck(:friend_id)
    friends_ids += reverse_friendships.where(confirmed: true).pluck(:user_id)
    User.where(id: friends_ids)
  end

  def friend?(user)
    friends.include?(user)
  end

  def friendship_request_sent?(user)
    friendships.find_by(friend: user, confirmed: false)
  end

  def friendship_request_received?(user)
    reverse_friendships.find_by(user: user, confirmed: false)
  end

  private

  def set_profile_image_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    self.profile_image_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
