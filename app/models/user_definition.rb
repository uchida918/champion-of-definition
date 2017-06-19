class UserDefinition < ApplicationRecord
    belongs_to :definition
    belongs_to :user
    
    validates :user_id, presence: true
    validates :definition_id, presence: true
    validates :custom_body, presence: true, length: { maximum: 500 }
   
end
