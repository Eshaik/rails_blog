# frozen_string_literal: true

# module to helper methods to user.
module UsersHelper

  # helper method to verify if user is owner of article or follower of article's owner.
  def f_m(user, article)
    article.is_owner?(user) || user.is_a_follower?(article.owner)
  end

end
