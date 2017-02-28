class RenameUserToAdminUser < ActiveRecord::Migration[5.0]
  def change
    rename_table :users, :admin_users
  end
end
