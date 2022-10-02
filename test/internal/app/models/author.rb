class Author < ActiveRecord::Base
  has_many :books
  has_many :publishers, through: :books
  has_many :movies
  has_one :profile
  has_one :profile_history, through: :profile
  has_and_belongs_to_many :magazines
  belongs_to :company
end
