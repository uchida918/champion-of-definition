class CreateOwnerships < ActiveRecord::Migration[5.0]
  def change
    create_table :ownerships do |t|
      t.references :user, foreign_key: true
      t.references :definition, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
