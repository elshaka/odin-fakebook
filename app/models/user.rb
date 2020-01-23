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
    direct_friends = friendships.map do |friendship|
      friendship.friend if friendship.confirmed
    end

    reverse_friends = reverse_friendships.map do |friendship|
      friendship.user if friendship.confirmed
    end

    direct_friends + reverse_friends
  end

  private

  def set_profile_image_url
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    self.profile_image_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
  end
end
