require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { FactoryBot.create :user }
  let(:post) { FactoryBot.create :post }

  it 'should reject posts with empty content' do
    comment_a = post.comments.build user: user
    expect(comment_a.valid?).to eql(false)
    comment_b = post.comments.build user: user, content: ''
    expect(comment_b.valid?).to eql(false)
    comment_c = post.comments.build user: user, content: '           '
    expect(comment_c.valid?).to eql(false)
  end

  it 'should accept posts with some content' do
    comment = post.comments.create user: user, content: 'First!'
    expect(post.comments.empty?).to eql(false)
    expect(comment.valid?).to eql(true)
  end
end
