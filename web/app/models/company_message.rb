# == Schema Information
#
# Table name: company_messages
#
#  id         :bigint           not null, primary key
#  content    :text
#  expires_in :datetime
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
  default_scope -> { where(expires_in: Time.now..).or(where(expires_in: nil)) }

  include MeiliSearch::Rails
  meilisearch do
    attribute :id, :content, :title, :company_id, :created_at

    searchable_attributes %i[content title]
    filterable_attributes %i[content title company_id id]
    sortable_attributes %i[created_at]
  end
end
