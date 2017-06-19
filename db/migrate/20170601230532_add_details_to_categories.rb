class AddDetailsToCategories < ActiveRecord::Migration[5.0]
  def change
    add_reference :categories, :area, foreign_key: true
  end
end
