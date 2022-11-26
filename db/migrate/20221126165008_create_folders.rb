class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :title
      t.references :parent_folder, foreign_key: {to_table: :folders}, null: true
      t.string :folder_path
      
      t.timestamps
    end
  end
end
