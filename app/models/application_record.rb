class ApplicationRecord < ActiveRecord::Base
  include DefaultColumn
  self.abstract_class = true
end
