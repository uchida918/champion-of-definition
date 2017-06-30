class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :username, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :user_definitions, dependent: :destroy
  has_many :definition_definitions, through: :user_definitions, source: :definition
  #内田コメント：ここはdestroyだけでよいのでしょうか？
  has_many :definitions, dependent: :destroy
end
