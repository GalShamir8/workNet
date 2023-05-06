# == Schema Information
#
# Table name: posts
#
#  id          :bigint           not null, primary key
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :attachments
  has_many :post_likes, dependent: :destroy, foreign_key: :post_id
  has_many :likes, through: :post_likes, source: :user
  has_many :comments
  default_scope -> { order(created_at: :desc) }
end
