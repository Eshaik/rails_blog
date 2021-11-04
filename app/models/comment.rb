# frozen_string_literal: true

# Comment model: Class to control all the  attributes, relations, and validation about comments.
class Comment < ApplicationRecord
  include Visible
  belongs_to :article

  scope :publics, -> {where ("status = 'public' ")}
  scope :owner_u, -> (user) { where("commenter = ?", user.username) }

  def owner
    User.find_by(username: self.commenter)
  end
  
end
