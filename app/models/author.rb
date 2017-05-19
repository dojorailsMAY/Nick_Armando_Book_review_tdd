class Author < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :books
end
