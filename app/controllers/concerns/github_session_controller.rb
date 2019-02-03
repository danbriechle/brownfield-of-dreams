class GithubSessionController < ApplicationController
    def create
        current_user.update(uid: request.env["omniauth.auth"].uid)
        current_user.update(token: request.env["omniauth.auth"].credentials.token)
        current_user.save
        redirect_to dashboard_path
    end 
end 