class Profile < ActiveRecord::Base
  belongs_to :author
  has_one :profile_history
  accepts_nested_attributes_for :profile_history
end
