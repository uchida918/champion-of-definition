class RenameDefinitonIdColumnToUserDefinitions < ActiveRecord::Migration[5.0]
  def change
    rename_column :user_definitions, :definiton_id, :definition_id
  end
end
