class Magazine < ActiveRecord::Base
  has_and_belongs_to_many :authors
end
