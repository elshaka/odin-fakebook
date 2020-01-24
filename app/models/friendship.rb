class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :friend, uniqueness: { scope: :user }
  validate :friend_isnt_same_as_user

  after_create :create_reverse_friendship

  def friend_isnt_same_as_user
    errors.add(:friend, "can't be the same as user") if friend_id == user_id
  end

  def create_reverse_friendship
    reverse_friendship = Friendship.new user: self.friend, friend: self.user, confirmed: self.confirmed
    reverse_friendship.save if reverse_friendship.valid?
  end
end
