# frozen_string_literal: true

class AddInfoToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :info, :string, null: false, default: ''
  end
end
