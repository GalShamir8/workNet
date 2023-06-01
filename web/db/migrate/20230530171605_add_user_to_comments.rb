class AddUserToComments < ActiveRecord::Migration[7.0]
  def up
    add_reference :comments, :user, null: false, foreign_key: true
  end
end