require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { FactoryBot.create :user }
  let(:post) { FactoryBot.create :post }

  it "should only allow one like per user per post" do
    post.likes.create user: user
    repeated_like = post.likes.create user: user

    expect(repeated_like.errors).to have_key(:post)
  end
end
