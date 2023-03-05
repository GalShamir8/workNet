class AddUserBirthDate < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :birth_date, :date
    remove_column :users, :age
  end
end
