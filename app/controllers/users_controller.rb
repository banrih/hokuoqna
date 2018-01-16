class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :likes]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = '登録完了！'
      redirect_to @user
    else
      flash.now[:danger] = '登録失敗！'
      render :new
    end
  end
  
  def like_posts
    @user = User.find(params[:id])
    @like_posts = current_user.like_posts.page(params[:page])
    counts(@user)
  end
  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
