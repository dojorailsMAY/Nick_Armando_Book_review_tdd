EMAIL_REGEX = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i

class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews
  validates :first_name, :last_name, :email, presence: true
  validates :email, :uniqueness => true, format: { with: EMAIL_REGEX, message: "Please enter a valid email" }

  def reviewed_books
    Book.joins(:reviews).where("reviews.user_id=?", self.id).distinct
  end

end
