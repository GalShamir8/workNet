class CreateTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :teams do |t|
      t.uuid :id
      t.string :name

      t.timestamps
    end
  end
end
