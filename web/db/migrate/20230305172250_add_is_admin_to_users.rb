class AddIsAdminToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :is_admin, :boolean, default: false
    add_index :users, :is_admin, name: 'is_admin_index_on_users', unique: false
  end
end
