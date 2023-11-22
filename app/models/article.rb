class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :user

  has_noticed_notifications model_name: 'Notification'
  has_many :notifications, through: :user, dependent: :destroy
end
