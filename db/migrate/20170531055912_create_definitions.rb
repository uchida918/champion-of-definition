class CreateDefinitions < ActiveRecord::Migration[5.0]
  def change
    create_table :definitions do |t|
      t.references :user
      t.references :category
      t.string :term
      t.string :body

      t.timestamps
    end
  end
end
