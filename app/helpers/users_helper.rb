# frozen_string_literal: true

module UsersHelper

  def f_m(user, article)
    article.is_owner?(user) || user.is_a_follower?(article.owner)
  end

end
