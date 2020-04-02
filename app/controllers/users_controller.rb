class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy] 

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

    def edit
    end

    
    def update
        @user = User.find_by(user_params)
        @user.name = params[:name]
        @user.email = params[:email]
        
        # 画像を保存する処理を追加してください
        if params[:image]
          @user.image_name = "#{@user.id}.jpg"
          image=params[:image]
          File.binwriter("public/user_images/#{@user.image_name}",image.read)
        end
        if @user.update(params[:id])
          flash[:notice] = "ユーザー情報を編集しました"
          redirect_to user_path
        else
          render("users/edit")
        end
    end

    def login
        @user = User.find_by(email: params[:email], password: params[:password])
        if @user
          session[:user_id] = @user.id
          flash[:notice] = "ログインしました"
          redirect_to("/posts/index")
        else
          @error_message = "メールアドレスまたはパスワードが間違っています"
          @email = params[:email]
          @password = params[:password]
          render("users/login_form")
        end
    end

    def logout
      session[:user_id] = nil
      flash[:notice] = "ログアウトしました"
      redirect_to("/login")
    end

    private
  
    def user_params
        params.require(:user).permit(:name, :email,:image_name, :password,
                                    :password_confirmation)
    end

    def set_user
      @user = User.find(params[:id])
    end

end