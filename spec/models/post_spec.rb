require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.build :post }
  it 'should validate the presence of the content' do
    post.content = nil
    post.validate

    expect(post.errors).to have_key(:content)
  end

  it 'should validate the existance of the post author' do
    post.user_id = 9999 # Non existent id
    post.validate

    expect(post.errors).to have_key(:user)
  end
end
