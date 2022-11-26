class AddUserIdToArchive < ActiveRecord::Migration[7.0]
  def change
    add_column :archives, :user_id, :bigint
  end
end
