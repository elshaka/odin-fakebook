require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { FactoryBot.create :user }
  let(:some_post) { FactoryBot.create :post }
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
      post :create, params: { post: post_params }, xhr: true

      expect(user.posts.last.content).to eql(post_params[:content])
    end
  end

  describe '#show' do
    it 'should retrieve the post' do
      get :show, params: { id: some_post.id }

      expect(assigns(:post)).to eql(some_post)
    end
  end

  describe '#like' do
    it 'should like the post as the current user' do
      post :like, params: { id: some_post.id }, xhr: true

      expect(some_post.likes.first.user).to eql(user)
    end
  end

  describe '#dislike' do
    it 'should dislike the post previously liked by the current user' do
      some_post.likes.create user: user

      post :dislike, params: { id: some_post.id }, xhr: true

      expect(some_post.likes.count).to eql(0)
    end
  end

  describe '#comment' do
    it 'should create a comment on the post' do
      expect(some_post.comments.empty?).to eql(true)
      post :comment, params: { id: some_post.id, content: 'First!' }
      expect(some_post.comments.empty?).to eql(false)
    end

    it 'should create multiple comments on the post' do
      expect(some_post.comments.count).to eql(0)
      post :comment, params: { id: some_post.id, content: 'First!' }
      post :comment, params: { id: some_post.id, content: 'Second!' }
      post :comment, params: { id: some_post.id, content: 'Third!' }
      expect(some_post.comments.count).to eql(3)
    end
  end
end
