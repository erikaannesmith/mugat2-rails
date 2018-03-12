class DesignerComment < ApplicationRecord
  validates :date, :body, :designer_id, presence: true
  belongs_to :designer

end