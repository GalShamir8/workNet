class AddIndexToPostRank < ActiveRecord::Migration[7.0]
  def change
    add_index :post_ranks, %i[user_id post_id], unique: true
  end
end
