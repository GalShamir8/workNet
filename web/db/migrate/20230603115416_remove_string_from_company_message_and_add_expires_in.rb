class RemoveStringFromCompanyMessageAndAddExpiresIn < ActiveRecord::Migration[7.0]
  def change
    remove_column :company_messages, :string, :string
    add_column :company_messages, :expires_in, :datetime
  end
end
