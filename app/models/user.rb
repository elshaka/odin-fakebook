class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :friendships
  has_many :friends, through: :friendships, class_name: 'User'
  has_many :reverse_friendships, class_name: 'Friendship', foreign_key: :friend_id
  has_many :reverse_friends, through: :reverse_friendships, source: :user
end