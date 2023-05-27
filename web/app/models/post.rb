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
  has_many :post_ranks, dependent: :destroy
  scope :user_posts, lambda { |user|
    joins(:user).left_joins(:post_ranks).where(
      user: { company_id: user.company_id },
      post_ranks: { user_id: user.id }
    ).order(
      created_at: :desc,
      rank: :desc
    )
  }

  include MeiliSearch::Rails
  meilisearch do
    attribute :id, :description, :user_id, :created_at
    attribute :user_name do
      user&.full_name
    end

    searchable_attributes %i[description user_name]
    filterable_attributes %i[user_name]
    sortable_attributes %i[created_at]
  end
end
