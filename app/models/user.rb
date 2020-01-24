class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where(friendships: { confirmed: true }) }, through: :friendships

  devise :database_authenticatable, :registerable, :validatable, :rememberable

  validates :name, presence: true, length: { maximum: 50 }

  before_save :set_profile_image_url

  def friend?(user)
    friends.include?(user)
  end

  def friendship_request_sent?(user)
    friendships.find_by(friend: user, confirmed: false)
  end

  def friendship_request_received?(user)
    friendships.find_by(user: user, confirmed: false)
  end

  def timeline_posts
    Post.where(user_id: [id] + friends_ids)
  end

  private

  def set_profile_image_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    self.profile_image_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end

  def friends_ids
    friendships.where(confirmed: true).pluck(:friend_id)
  end
end
