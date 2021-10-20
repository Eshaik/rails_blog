# frozen_string_literal: true

# Comment model: Class to control all the  attributes, relations, and validation about comments.
class Comment < ApplicationRecord
  include Visible
  belongs_to :article
end
