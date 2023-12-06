class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :notifications, as: :recipient, dependent: :destroy

  enum role: [:user, :admin, :guest]
  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= :user
  end

   # Class method to whitelist searchable attributes for Ransack
   def self.ransackable_attributes(auth_object = nil)
    ["email", "name"]
  end

end
