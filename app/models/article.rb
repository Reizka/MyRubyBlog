class Article < ApplicationRecord
  include Visible

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :body
  has_one :content, class_name: 'ActionText::RichText',as: :record, dependent: :destroy

  has_noticed_notifications model_name: 'Notification'
  has_many :notifications, through: :user, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["body", "title"]
  end
end
