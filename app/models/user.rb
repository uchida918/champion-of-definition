class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :username, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :user_definitions, dependent: :destroy
  has_many :definition_definitions, through: :user_definitions, source: :definition
  has_many :definitions, dependent: :destroy
  
  has_many :ownerships
  has_many :ownership_definitions, through: :ownerships, source: :definition
  has_many :favorites
  has_many :favorite_definitions, through: :favorites, class_name: 'Definition', source: :definition
  has_many :memories
  has_many :memory_definitions, through: :memories, class_name: 'Definition', source: :definition
  
  def favorite(definition)
    self.favorites.find_or_create_by(definition_id: definition.id)
  end
  
  def unfavorite(definition)
    favorite = self.favorites.find_by(definition_id: definition.id)
    favorite.destroy if favorite
  end
  
  def favorite?(definition)
    self.favorite_definitions.include?(definition)
  end
  
  def memory(definition)
     self.memories.find_or_create_by(definition_id: definition.id)
  end
  
  def unmemory(definition)
    memory = self.memories.find_by(definition_id: definition.id)
    memory.destroy if memory
  end
  
  def memory?(definition)
    self.memory_definitions.include?(definition)
  end
end
