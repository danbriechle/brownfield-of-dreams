class UsersController < ApplicationController
  def show
    if current_user.token 
      @user = UserFacade.new(current_user)
    elsif current_user.active == nil || current_user.active == false
      flash[:notice] = "This account has not yet been activated. Please check your email."
    end
      @bookmarks = BookmarkFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      VerificationMailer.verify(params[:user][:email], current_user).deliver_now
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def verify
    user = User.find(params[:id])
    user.update(active: true)
    session[:user_id] = user.id
    flash[:notice] = "Thank you! Your account is now activated."
    redirect_to dashboard_path
  end 

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
