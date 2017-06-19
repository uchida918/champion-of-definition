class Category < ApplicationRecord
    belongs_to :area
    
    has_many :definitions
    
    validates :area_id, presence: true
     validates :name, presence: true, length: { maximum: 50 }
end
