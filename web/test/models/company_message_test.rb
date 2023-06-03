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
require "test_helper"

class CompanyMessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
