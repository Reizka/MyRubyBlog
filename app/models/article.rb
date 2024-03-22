class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: %i[slugged history finders]

  include Visible

  validates :title, presence: true, length: { minimum: 5, maximum: 50 }
  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :body
  has_one :content, class_name: 'ActionText::RichText', as: :record, dependent: :destroy
  has_and_belongs_to_many :tags
  has_noticed_notifications model_name: "Notification"
  has_many :notifications, through: :user

  def should_generate_new_friendly_id?
    title_changed? || slug.blank?
  end

  def self.ransackable_attributes(auth_object = nil)
    ["body", "title"]
  end
end
