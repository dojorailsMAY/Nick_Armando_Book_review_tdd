class Book < ActiveRecord::Base
  belongs_to :author
  validates :title, :author, presence: true, length:{minimum: 2}
  has_many :reviews
end
