require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryBot.create :user }
  before { sign_in user }

  describe '#index' do
    before { 10.times { user.posts.create FactoryBot.attributes_for :post } }
    it 'should retrieve the current user timeline posts' do
      get :index

      expect(assigns(:timeline_posts)).to match_array(user.posts)
    end
  end

  describe '#create' do
    it 'should create a post for the current user' do
      post_params = FactoryBot.attributes_for :post
      post :create, params: {post: post_params}, xhr: true

      expect(user.posts.last.content).to eql(post_params[:content])
    end
  end

  describe '#show' do
    it 'should retrieve the post' do
      post = FactoryBot.create :post, user: user
      get :show, params: {id: post.id}

      expect(assigns(:post)).to eql(post)
    end
  end
end
