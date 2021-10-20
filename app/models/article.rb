# frozen_string_literal: true

# Article model: Class to set all the attributes, relations, and validation about Article.
class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
