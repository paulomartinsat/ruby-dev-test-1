class AddUserIdToFolder < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :user_id, :bigint
  end
end
