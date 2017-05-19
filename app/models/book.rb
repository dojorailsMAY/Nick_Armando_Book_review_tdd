class Book < ActiveRecord::Base
  belongs_to :author
  validates :title, :author, presence: true
  has_many :reviews
end
