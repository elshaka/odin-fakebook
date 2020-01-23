class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :friend_validity
  validate :friendship_uniqueness

  def friend_validity
    errors.add(:friend, "can't be the same as user") if friend_id == user_id
  end

  def friendship_uniqueness
    if friendship = Friendship.find_by(user_id: user_id, friend_id: friend_id) || Friendship.find_by(user_id: friend_id, friend_id: user_id)
      errors.add(:friend, friendship.confirmed ? 'already exists' : 'request is pending')
    end
  end
end
