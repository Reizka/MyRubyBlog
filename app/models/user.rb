class User < ApplicationRecord
  # Devise modules for authentication and account management
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Relationships
  has_many :articles, dependent: :destroy  # User has many articles, delete articles if user is deleted
  has_many :comments, dependent: :destroy  # User has many comments, delete comments if user is deleted
  has_many :notifications, as: :recipient, dependent: :destroy  # User can receive many notifications
  has_one :address, dependent: :destroy, inverse_of: :user, autosave: true  # User has one address, delete address if user is deleted

  # Enums for user roles
  enum role: [:user, :admin, :guest]

  # Callbacks
  after_initialize :set_default_role, if: :new_record?  # Set default role on new record initialization

  # Validations
  with_options if: -> { required_for_step?('set_name') } do |step|
    step.validates :first_name, presence: true  # Validate first name in 'set_name' step
    step.validates :last_name, presence: true  # Validate last name in 'set_name' step
  end

  validates_associated :address, if: -> { required_for_step?('set_address') }  # Validate associated address in 'set_address' step

  # Nested attributes
  accepts_nested_attributes_for :address, allow_destroy: true

  # Form steps for multi-step form process
  cattr_accessor :form_steps do
    %w[sign_up set_name set_address find_users]
  end

  # Instance variable for tracking current form step
  attr_accessor :form_step

  # Getter method for form_step, defaults to 'sign_up'
  def form_step
    @form_step || "sign_up"
  end

  # Instance methods
  def full_name
    "#{first_name unless first_name.nil?} #{last_name unless last_name.nil?}"  # Full name method combining first and last name
  end

  def required_for_step?(step)
    form_step.nil? || form_steps.index(step.to_s) <= form_steps.index(form_step.to_s)
  end

  # Class methods
  def self.ransackable_attributes(auth_object = nil)
    ["email", "name"]  # Whitelist searchable attributes for Ransack
  end

  private

  def set_default_role
    self.role ||= :user  # Set default role to 'user' if none is provided
  end

end
