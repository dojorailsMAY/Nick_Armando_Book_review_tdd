class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :book

	validates :content, :book, :user, :rating, presence: true
	validates_inclusion_of :rating, :in => 1..5, :message => 'is required'

	def self.last_three
		self.order(created_at: :desc).limit(3).includes(:user).includes(:book)  # eager load
	end

end
