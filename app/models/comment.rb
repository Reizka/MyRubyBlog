class Comment < ApplicationRecord
  include Visible

  belongs_to :article
  belongs_to :user
  #validates :title, presence: true
  #validates :body, presence: true, length: { minimum: 2 }
end
