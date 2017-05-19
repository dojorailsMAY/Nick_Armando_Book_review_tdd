class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if !@user
      flash[:errors] = ["Invalid Email or Password"]
      return redirect_to '/sessions/new'
    end

    if @user.authenticate(params[:password])
      session[:user_id] = @user.id
      return redirect_to '/books'
    end
    flash[:errors] = ["Invalid Email or Password"]
    redirect_to '/sessions/new'
  end

  def destroy
    session.clear
    redirect_to '/sessions/new'
    
  end
end
