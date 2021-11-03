# frozen_string_literal: true

module ArticlesHelper

  def f_author(article)
    @user = User.find_by(username: article.author).id
  end

end
