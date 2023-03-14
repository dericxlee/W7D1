class UsersController < ApplicationController
    # before_action :required_logged_in, [:new]

    def new
        user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login!(@user)  #reassigns session_token
            redirect_to cats_url #renders cats index page
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end
