# frozen_string_literal: true

# Follow model: Class to control all the  attributes, relations, and validation about follow.
class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
