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
end
