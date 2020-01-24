class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :friend, uniqueness: { scope: :user }
  validate :friend_isnt_same_as_user

  after_create :create_reverse_friendship
  after_update :update_reverse_friendship_status
  after_destroy :destroy_reverse_friendship

  def friend_isnt_same_as_user
    errors.add(:friend, "can't be the same as user") if friend_id == user_id
  end

  def create_reverse_friendship
    reverse_friendship = Friendship.new user: friend, friend: user, confirmed: confirmed, sent: false
    reverse_friendship.save if reverse_friendship.valid?
  end

  def update_reverse_friendship_status
    Friendship.find_by(user: friend, friend: user).update_column(:confirmed, confirmed)
  end

  def destroy_reverse_friendship
    reverse_friendship = Friendship.find_by(user: friend, friend: user)
    reverse_friendship.destroy if reverse_friendship.present?
  end
end
