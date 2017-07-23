class Definition < ApplicationRecord
  belongs_to :category
  belongs_to :user
  
  has_many :user_definitions, dependent: :destroy
  has_many :definition_users, through: :user_definitions , source: :user
  
  validates :term, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 200 }
  validates :user_id, presence: true
  validates :category_id, presence: true
  
  has_many :ownerships
  has_many :ownership_users, through: :ownerships, source: :user

  has_many :favorites
  has_many :favorite_users, through: :favorites, class_name: 'User', source: :user
  has_many :memories
  has_many :memory_users, through: :memories, class_name: 'User', source: :user
end
