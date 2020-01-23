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
      post :send_friend_request, params: { id: friend.id }
      expect(user.friendships.empty?).to eql(false)
    end
  end

  describe '#accept_friend_request' do
    it 'should accept a friend request' do
      friend = FactoryBot.create :user      
      friendship = friend.friendships.create friend_id: user.id
      post :accept_friend_request, params: { id: friend.id }
      expect(friend.friends).to include(user)
    end
  end
end
