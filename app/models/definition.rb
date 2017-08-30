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
  
  def self.import(file)
    CSV.foreach(file.path, headers: true, encoding: "Shift_JIS:UTF-8") do |row|

      # IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
      definition = Definition.find_by(category_id: row['category_id'].to_i, term: row['term']) || new
      # CSVからデータを取得し、設定する
      definition.attributes = row.to_hash.slice(*updatable_attributes)
      # 保存する
      definition.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["user_id", "category_id", "term", "body"]
  end
end
