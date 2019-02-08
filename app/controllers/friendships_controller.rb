class FriendshipsController < ApplicationController
    def create
        new_homie = User.find_by(uid: params[:friend_id])
        @current_user = current_user
        @friendship = Friendship.new(user_id: @current_user.id, friend_id: new_homie.id)
        if @friendship.save
            flash[:notice] = "Friend Added!"
            redirect_to dashboard_path
        end
    end
end
