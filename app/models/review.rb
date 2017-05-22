class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :content, :book, :user, :rating, presence: true
  validates_inclusion_of :rating, :in => 1..5, :message => 'is required'

end
