# frozen_string_literal: true

# module to helper methods to user.
module UsersHelper

  # helper method to verify if user is owner of article or follower of article's owner.
  def f_m(user, article)
    article.is_owner?(user) || user.is_a_follower?(article.owner)
  end

  # helper method to count user's public articles
  def count_own_articles_p(user)
    (Article.select { |a| a.author == @user.username && a.status == 'public'}).length
  end

  # helper method to count user's publi comments.
  def count_own_comments_p(user)
    (Comment.select { |c| c.commenter == user.username  && c.status == 'public' }).length 
  end
end
