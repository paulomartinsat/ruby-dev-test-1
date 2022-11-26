class CreateArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :archives do |t|
      t.string :title
      t.references :folder, foreign_key: true, null: false 
      t.timestamps
    end
  end
end
