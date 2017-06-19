class Area < ApplicationRecord
  has_many :categories
  
  validates :name, presence: true, length: { maximum: 50 }
end
