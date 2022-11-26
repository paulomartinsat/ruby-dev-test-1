class AddEncryptedPasswordConfirmationToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :encrypted_password_confirmation, :string
  end
end
