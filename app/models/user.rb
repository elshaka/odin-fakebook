class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where(friendships: { confirmed: true }) }, through: :friendships
  has_many :notifications, dependent: :destroy

  devise :database_authenticatable, :registerable, :validatable, :rememberable
  devise :omniauthable, omniauth_providers: %i[facebook]

  validates :name, presence: true, length: { maximum: 50 }

  before_save :set_profile_image_url

  def timeline_posts
    Post.where(user_id: [id] + friends.pluck(:id))
  end

  def send_friend_request(user)
    friendships.create(friend: user)
    user.notifications.create(
      title: "#{name} sent you a friendship request",
      url: user_path(self),
      icon: 'user-friends'
    )
  end

  def cancel_friend_request(user)
    friendships.find_by(friend: user, confirmed: false, sent: true)&.destroy
  end

  def accept_friend_request(user)
    friendships.find_by(friend: user)&.update_attribute(:confirmed, true)
    user.notifications.create(
      title: "#{name} accepted your friendship request",
      url: user_path(self),
      icon: 'user-friends'
    )
  end

  def reject_friend_request(user)
    friendships.find_by(friend: user, confirmed: false, sent: false)&.destroy
  end

  def delete_friend(user)
    friends.destroy(user)
  end

  def friend?(user)
    friends.include?(user)
  end

  def friendship_request_sent?(user)
    friendships.where(friend: user, confirmed: false, sent: true).any?
  end

  def friendship_request_received?(user)
    friendships.where(friend: user, confirmed: false, sent: false).any?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  private

  def set_profile_image_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    self.profile_image_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
