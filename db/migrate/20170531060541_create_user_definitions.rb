class CreateUserDefinitions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_definitions do |t|
      t.references :user
      t.references :definiton
      t.string :custom_body
      t.boolean :memory, :boolean, default: false, null: false
      t.boolean :favorite, :boolean, default: false, null: false

      t.timestamps
    end
  end
end
