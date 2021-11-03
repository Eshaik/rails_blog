# frozen_string_literal: true

module UsersHelper

  def fom(user, article)
    user.following?(User.find_by(username: article.author)) || user.username == article.author
  end

end
