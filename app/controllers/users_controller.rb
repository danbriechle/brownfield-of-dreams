class UsersController < ApplicationController
  def show
    if current_user.token
      raw_repos = GithubService.repos(current_user)
      # @repos = Repo.generate(raw_repos).take(5)
      @repos = current_user.repo_factory.take(5)
      @followers = current_user.follower_factory
      @followings = current_user.following_factory
    end
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

  # def conn(token)
  #   conn = Faraday.new(url: "https://api.github.com") do |f|
  #     f.headers["Authorization"] = "Token #{token}"
  #     f.adapter Faraday.default_adapter
  #   end
  #   conn.get "/user/repos"
  # end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

end
