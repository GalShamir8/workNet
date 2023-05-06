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

  def like_icon(post)
    icon_class = post.likes.include?(current_user) ? 'glyphicon glyphicon-heart' : 'glyphicon glyphicon-heart-empty'
    "<i class='#{icon_class}'></i>"
  end

  def number_of_likes(post)
    post.likes.count
  end
end
