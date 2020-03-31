class UsersController < ApplicationController
    def new
        @user = User.new
    end
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "登録しました！"
            redirect_to new_session_path
        else
            flash.now[:danger] = "失敗しました！"
            render :new
        end
    end

    def show
      @user = User.find(params[:id])
      @blogs = @user.blogs
    end

    private
  
    def user_params
        params.require(:user).permit(:name, :email, :password,
                                    :password_confirmation)
    end
end