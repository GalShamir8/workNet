class CreatePostRanks < ActiveRecord::Migration[7.0]
  def change
    create_table :post_ranks do |t|
      t.references :post, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :rank

      t.timestamps
    end
  end
end
