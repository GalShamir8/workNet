# frozen_string_literal: true

# PostsHelper
module PostsHelper
  def post_likes(post)
    [
      number_of_likes(post),
      '&nbsp;',
      like_icon(post)
    ].join.html_safe
  end

  def like_icon(post)
    # icon_class = post.likes.include?(current_user) ? 'glyphicon glyphicon-heart' : 'glyphicon glyphicon-heart-empty'
    icon_class = post.user == current_user ? 'glyphicon glyphicon-heart' : 'glyphicon glyphicon-heart-empty'
    "<i class='#{icon_class}'></i>"
  end

  def number_of_likes(post)
    # post.likes.count
    0
  end
end
