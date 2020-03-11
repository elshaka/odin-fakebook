class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :post, uniqueness: { scope: :user }

  after_create :create_notification

  def create_notification
    post.user.notifications.create(
      title: "#{user.name} liked your post",
      url: post_path(post),
      icon: 'heart'
    ) unless self.user.id == self.post.user.id
  end
end
