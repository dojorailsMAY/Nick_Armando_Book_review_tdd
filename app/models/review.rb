class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  validates :content, :book, :user, presence: true

end
