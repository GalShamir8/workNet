class CreateCompanyMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :company_messages do |t|
      t.references :company, null: false, foreign_key: true
      t.text :content
      t.string :title
      t.string :string

      t.timestamps
    end
  end
end
