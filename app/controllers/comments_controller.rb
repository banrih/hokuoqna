class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def show
    @comments = @post.comments.order('created_at ASC').page(params[:page])
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post = Post.find(params[:post_id])
    
    if @comment.save
      flash[:success] = '送信完了！'
      redirect_to root_url
    else
      @post = Post.find(params[:post_id])
      @comment = Comment.new
      @comments = @post.comments.order('created_at ASC').page(params[:page])
      
      # @comment = current_user.comments.order('created_at ASC').page(params[:page])
      flash.now[:danger] = '送信失敗！'
      render 'posts/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = '削除完了！'
    redirect_to root_url
  end
  
  
  private

  def comment_params
    params.require(:comment).permit(:content)
  end
  
  def correct_user
    @comment = current_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end
