require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { FactoryBot.create :user }
  let(:friend) { FactoryBot.create :user }

  it 'should validate friendship uniqueness' do
    friendship = user.friendships.create friend: friend
    duplicated_friendship = user.friendships.build friend: friend
    duplicated_friendship.validate

    expect(duplicated_friendship.errors).to have_key(:friend)
  end

  it 'should validate friend is not the same as the user' do
    friendship = user.friendships.create friend: user
    friendship.validate

    expect(friendship.errors).to have_key(:friend)
  end

  it 'should set confirmed = false by default' do
    friendship = Friendship.create user: user, friend: friend

    expect(friendship.confirmed).to be false
  end

  it 'should create the reverse friendship after create' do
    Friendship.create user: user, friend: friend
    reverse_friendship = Friendship.where(user: friend, friend: user)

    expect(reverse_friendship.exists?).to be true
  end

  it 'should update the reverse friendship after update' do
    friendship = Friendship.create user: user, friend: friend
    friendship.update_attribute(:confirmed, true)

    reverse_friendship = Friendship.find_by(user: friend, friend: user)

    expect(reverse_friendship.confirmed).to be true
  end

  it 'should destroy the reverse friendship after destroy' do
    friendship = Friendship.create user: user, friend: friend
    friendship.destroy

    reverse_friendship = Friendship.where(user: friend, friend: user)

    expect(reverse_friendship.exists?).to be false
  end
end
