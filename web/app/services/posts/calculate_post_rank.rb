# frozen_string_literal: true

# module Posts
module Posts
  # CalculatePostRank = Calculate post rank to a user
  class CalculatePostRank
    RANKS = {
      owner: 30,
      team: 10,
      department: 6,
      like: 2
    }.freeze

    def initialize(post:)
      @post = post
    end

    def call
      process!
    end

    private

    def process!
      @o_rank = owner_rank
      @t_rank = team_rank
      @d_rank = department_rank
      @l_rank = like_rank
      user_ids = Set.new(
        @o_rank.keys +
        @t_rank.keys +
        @d_rank.keys +
        @l_rank.keys
      )
      create_ranks(user_ids)
    end

    def create_ranks(user_ids)
      data = user_ids.map.to_h do |user_id|
        [
          user_id,
          {
            rank: fetch_rank(user_id),
            post_id: @post.id,
            user_id: user_id
          }
        ]
      end
      PostRank.insert_all(data.values) unless data.empty?
    end

    def fetch_rank(user_id)
      @o_rank[user_id].to_i + @t_rank[user_id].to_i + @d_rank[user_id].to_i + @l_rank[user_id].to_i
    end

    def owner_rank
      { @post.user.id => RANKS[:owner] }
    end

    def team_rank
      User.where(
        team_id: @post.user.team_id
      ).select(
        :id
      ).group_by(&:id).transform_values do |_u_arr|
        RANKS[:team]
      end
    end

    # RODO: add department
    def department_rank
      {}
    end

    def like_rank
      PostLike.joins(:post).where(
        post: { user_id: @post.user_id }
      ).group(:user_id).count.transform_values do |number_of_likes|
        number_of_likes * RANKS[:like]
      end
    end
  end
end
