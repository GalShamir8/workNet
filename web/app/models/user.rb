# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  birth_date             :date
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  is_admin               :boolean          default(FALSE)
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint
#  team_id                :bigint
#
# Indexes
#
#  index_users_on_company_id            (company_id)
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  is_admin_index_on_users              (is_admin)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many_attached :profile_pictures
  has_many :posts, dependent: :destroy
  belongs_to :team, optional: true
  belongs_to :department, optional: true
  belongs_to :company
  has_many :post_likes, dependent: :destroy, foreign_key: :user_id
  has_many :liked, through: :post_likes, source: :post
  has_many :post_ranks, dependent: :destroy, foreign_key: :user_id
  has_many :comments, dependent: :destroy

  include MeiliSearch::Rails
  meilisearch do
    attribute :id, :first_name, :last_name, :created_at, :email, :company_id
    attribute :full_name do
      full_name
    end
    attribute :team_name do
      team&.name
    end

    searchable_attributes %i[first_name last_name email full_name team_name]
    filterable_attributes %i[full_name first_name last_name company_id]
    sortable_attributes %i[created_at]
  end

  def close_friends
    User.where(team_id:).excluding(self)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
