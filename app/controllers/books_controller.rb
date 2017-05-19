class BooksController < ApplicationController
  def index
    @user = User.find(session[:user_id])
    @books = Book.all
    @reviews = Review.order(created_at: :desc).limit(3)
  end

  def show
    @book = Book.find(params[:book_id])
    @reviews = @book.reviews
  end

  def new
  end

  def create
  end
end
