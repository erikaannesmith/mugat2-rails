class Style < ApplicationRecord
  validates :name, :description, :designer_id, presence: true
  belongs_to :designer
  has_many :style_comments

end