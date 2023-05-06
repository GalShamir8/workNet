# frozen_string_literal: true

# module Posts
module Posts
  # CalculatePostRank = Calculate post rank to a user
  class CalculatePostRank
    def initialize(post:)
      @post = post      
    end

    def call
      process!
    end

    private

    def process!
      team_rank
      department_rank
      like_rank
    end
  end
end
