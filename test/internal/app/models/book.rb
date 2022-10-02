class Book < ActiveRecord::Base
  belongs_to :author
  belongs_to :publisher
  accepts_nested_attributes_for :publisher
end
