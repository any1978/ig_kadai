class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  
  def index
    @blogs = Blog.all
  end

  def new
    @blog = current_user.blogs.build
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog =  Blog.new
    end
  end

  def create
    @blog = current_user.blogs.build(blog_params)
    if @blog.save
      # UsernotifierMailer.send_submit_email(@contact).deliver
      redirect_to user_path(current_user.id), notice: "ブログを作成しました！確認メールを送信しました！"
    else
      render :new
    end
  end
  
  def show
    @blog = Blog.find(params[:id])
    @user = @blog.user
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
    @favorites= @blog.favorite_users
  end

  def edit
    if @blog.user_id != current_user.id
      flash[:notice] = "編集するが権限がありません"
      redirect_to blogs_path
    end
  end

  def update
    # @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      # UsernotifierMailer.send_submit_email(@contact).deliver
      redirect_to user_path(current_user.id), notice: "ブログを編集しました！確認メールを送信しました！"
    else
      render :edit
    end
  end
  
  def destroy
    if @blog.user_id != current_user.id
      flash[:notice] = "削除する権限がありません"
      redirect_to user_path
    end
    @blog.destroy
    redirect_to user_path(current_user.id), notice:"ブログを削除しました！"
  end
  
  def confirm
    @blog = current_user.blogs.build(blog_params)
    render :new if @blog.invalid?
    # redirect_to user_path(current_user.id), notice: "ブログを編集しました！" if @blog.invalid?   
  end 

  private

  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache, :remove_image, :email, :message)
  end

  # idをキーとして値を取得するメソッドを追加
  def set_blog
    @blog = Blog.find(params[:id])
  end
end
