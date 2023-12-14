class Comment < ApplicationRecord
  include Visible

  belongs_to :article, counter_cache: true
  belongs_to :user
  #validates :title, presence: true
  #validates :body, presence: true, length: { minimum: 2 }

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  private

  def notify_recipient
    return if article.user == user
    CommentNotification.with(comment: self, article: article).deliver_later(article.user)
  end

  def cleanup_notifications
    notifications_as_comment.destroy_all
  end

end