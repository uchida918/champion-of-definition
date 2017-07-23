class Ownership < ApplicationRecord
  belongs_to :user
  belongs_to :definition
end
