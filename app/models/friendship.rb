class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates :friend, uniqueness: { scope: :user }
  validate :friend_isnt_same_as_user

  def friend_isnt_same_as_user
    errors.add(:friend, "can't be the same as user") if friend_id == user_id
  end
end
