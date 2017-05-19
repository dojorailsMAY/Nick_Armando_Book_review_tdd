class UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      return redirect_to '/books'
    end
    flash[:errors] = @user.errors.full_messages
    redirect_to '/sessions/new'
  end

  def show
    @user = User.find(params[:user_id])
    @books = Book.joins(:reviews).where("reviews.user_id=?", @user.id)
  end

private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
