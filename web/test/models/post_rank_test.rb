# == Schema Information
#
# Table name: post_ranks
#
#  id         :bigint           not null, primary key
#  rank       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_post_ranks_on_post_id  (post_id)
#  index_post_ranks_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (post_id => posts.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class PostRankTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
