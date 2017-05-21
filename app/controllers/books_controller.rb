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
    @user = User.find(session[:user_id])
    @author = Author.find_by(name: params[:book_author])
    if @author == nil
      @author = Author.create(name: params[:book_new_author])
    end 
    @book = Book.create(title: params[:book_title], author: @author)
    @review = Review.create(content: params[:book_review], user:@user, book: @book, rating: params[:book_rating])
    if @book.valid? && @review.valid? && @author.valid?
      return redirect_to '/books/%s' % @book.id
    else
      flash[:errors] = @review.errors.full_messages
      return redirect_to '/books/new'
    end
  end
end
