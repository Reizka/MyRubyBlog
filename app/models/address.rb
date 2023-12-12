class Address < ApplicationRecord
  belongs_to :user, inverse_of: :address
  validates :street, :city, :postcode, :country, presence: true

end
