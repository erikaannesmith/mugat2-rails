class Designer < ApplicationRecord
  validates :company, :contact, :phone, :email, :user_id, presence: true
  belongs_to :user
  has_many :styles
  has_many :designer_comments

end