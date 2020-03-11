class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :content, presence: true

  default_scope { includes(:user) }

  after_create :create_notification

  def create_notification
    post.user.notifications.create(
      title: "#{user.name} commented on your post",
      url: post_path(post) + "#comment-#{id}",
      icon: 'comment'
    ) # unless self.user.id == self.post.user.id
  end
end
