class Definition < ApplicationRecord
    belongs_to :category
    belongs_to :user
    
    has_many :user_definitions, dependent: :destroy
    has_many :definition_users, through: :user_definitions , source: :user
    #内田コメント：Definitionのuser_idはadminだけになるので，userをhas_manyする必要はないということでしょうか？
    
    # validates :term, presence: true, length: { maximum: 50 }
    # validates :body, presence: true, length: { maximum: 200 }
    # validates :user_id, presence: true
    # validates :category_id, presence: true
    #内田コメント：Definitionモデルに存在しないカラムのvalidationをしていた理由はなぞですが，存在するカラムに修正してみました。
end
