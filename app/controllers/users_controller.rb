class UsersController < ApplicationController
  def show
    binding.pry
    @repos = conn(current_user.token)
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  def conn(token)
    conn = Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = "Token #{ENV["DAN_GIT_API_KEY"]}"
      f.adapter Faraday.default_adapter
    end
    conn.get "/user/repos"
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
