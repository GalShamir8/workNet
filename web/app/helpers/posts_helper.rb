# frozen_string_literal: true

# PostsHelper
module PostsHelper
  def post_likes(post)
    link_to post_like_path(post), method: :patch do
      [
        number_of_likes(post),
        '&nbsp;',
        like_icon(post)
      ].join.html_safe
    end
  end

  def post_comments(post)
    link_to post_path(post) do
      [
        number_of_comments(post),
        '&nbsp;',
        '<i class="glyphicon glyphicon-comment"></i>'
      ].join.html_safe
    end
  end

  private

  def like_icon(post)
    icon_class = post.likes.include?(current_user) ? 'glyphicon glyphicon-heart' : 'glyphicon glyphicon-heart-empty'
    "<i class='#{icon_class}'></i>"
  end

  def number_of_likes(post)
    post.likes.count
  end

  def number_of_comments(post)
    post.comments.count
  end
end
