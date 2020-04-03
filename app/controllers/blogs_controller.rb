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
      binding.irb
      UserNotifierMailer.send_submit_email(@blog.user.email).deliver_later
      redirect_to user_path(current_user.id), notice: "ブログを作成しました！"
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
  end

  def update
    # @blog = Blog.find(params[:id])
    if @blog.update(blog_params)
      redirect_to user_path(current_user.id), notice: "ブログを編集しました！"
    else
      render :edit
    end
  end
  
  def destroy
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
    params.require(:blog).permit(:title, :content, :image, :image_cache, :remove_image)
  end

  # idをキーとして値を取得するメソッドを追加
  def set_blog
    @blog = Blog.find(params[:id])
  end
end
