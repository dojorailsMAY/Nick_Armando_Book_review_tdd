class ReviewsController < ApplicationController
  def create

    @user = current_user
    @book = Book.find(params[:book_id])
    @review = Review.new(content:params[:content], user:@user, book:@book, rating:params[:rating].to_i)
    flash[:errors] = @review.errors.full_messages unless @review.save
    redirect_to '/books/%s' % @book.id
  end

end
