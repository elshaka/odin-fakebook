require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create :user }
  before { sign_in user }

  describe '#index' do
    it 'should return a list of all users' do
      10.times { FactoryBot.create :user }
      get :index
      expect(assigns(:users).length).to eql(11)
    end
  end

  describe '#show' do
    it 'should return the user with given id' do
      new_user = FactoryBot.create :user
      get :show, params: { id: new_user.id }
      expect(assigns(:user)).to eql(new_user)
    end
  end

  describe '#send_friend_request' do
    it 'should create a friend request' do
      friend = FactoryBot.create :user
      expect(user.friendships.empty?).to eql(true)
      expect(friend.friendships.empty?).to eql(true)
      post :send_friend_request, params: { id: friend.id }, xhr: true
      expect(user.friendships.empty?).to eql(false)
      expect(friend.friendships.empty?).to eql(false)
    end
  end

  describe '#accept_friend_request' do
    it 'should accept a friend request' do
      friend = FactoryBot.create :user
      friend.friendships.create friend: user
      expect(user.friends).not_to include(friend)
      expect(friend.friends).not_to include(user)
      post :accept_friend_request, params: { id: friend.id }, xhr: true
      user.reload
      friend.reload
      expect(user.friends).to include(friend)
      expect(friend.friends).to include(user)
    end
  end

  describe '#cancel_friend_request' do
    it 'should erase a pending friend request' do
      friend = FactoryBot.create :user
      user.friendships.create friend: friend
      expect(user.friendships.empty?).to eql(false)
      expect(friend.friendships.empty?).to eql(false)
      post :cancel_friend_request, params: { id: friend.id }, xhr: true
      user.reload
      friend.reload
      expect(user.friendships.empty?).to eql(true)
      expect(friend.friendships.empty?).to eql(true)
    end
  end

  describe '#reject_friend_request' do
    it 'should erase a pending friend request' do
      friend = FactoryBot.create :user
      friend.friendships.create friend: user
      expect(user.friendships.empty?).to eql(false)
      expect(friend.friendships.empty?).to eql(false)
      post :reject_friend_request, params: { id: friend.id }, xhr: true
      user.reload
      friend.reload
      expect(user.friendships.empty?).to eql(true)
      expect(friend.friendships.empty?).to eql(true)
    end
  end

  describe '#delete_friend' do
    it 'should erase a confirmed friendship relation' do
      friend = FactoryBot.create :user
      user.friendships.create friend: friend, confirmed: true
      expect(user.friends).to include(friend)
      expect(friend.friends).to include(user)
      post :delete_friend, params: { id: friend.id }, xhr: true
      expect(user.friends).not_to include(friend)
      expect(friend.friends).not_to include(user)
    end
  end
end
