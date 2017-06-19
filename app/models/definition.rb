class Definition < ApplicationRecord
    belongs_to :category
    belongs_to :user
    
    has_many :user_definitions
    has_many :users, through: :user_definitions , source: :user
    
    validates :name, presence: true, length: { maximum: 50 }
    validates :area_id, presence: true
end
