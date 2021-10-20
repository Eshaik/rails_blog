# frozen_string_literal: true

# Application record model: Model of MVC, to create and use datas.
# Full guide: https://guides.rubyonrails.org/active_record_basics.html
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
