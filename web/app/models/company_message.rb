# == Schema Information
#
# Table name: company_messages
#
#  id         :bigint           not null, primary key
#  content    :text
#  string     :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
# Indexes
#
#  index_company_messages_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class CompanyMessage < ApplicationRecord
  belongs_to :company
end
