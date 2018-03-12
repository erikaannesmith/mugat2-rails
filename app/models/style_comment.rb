class StyleComment < ApplicationRecord
  validates :date, :body, :style_id, presence: true
  belongs_to :style

end