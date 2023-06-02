# == Schema Information
#
# Table name: links
#
#  id         :bigint           not null, primary key
#  href       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#
# Indexes
#
#  index_links_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class Link < ApplicationRecord
  belongs_to :company
  validates :name, presence: true
  validates :href, presence: true
end
