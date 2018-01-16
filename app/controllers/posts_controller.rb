class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order('created_at ASC').page(params[:page])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      flash[:success] = '送信完了！'
      redirect_to root_url
    else
      @posts = current_user.posts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '送信失敗！'
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    Like.where(post_id: @post.id).delete_all
    @post.destroy
    flash[:success] = '削除完了！'
    redirect_to root_url
  end
  
  
  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
end
