class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = current_user.comments.build(comment_params)
    
    if @comment.save
      flash[:success] = '送信完了！'
      redirect_to root_url
    else
      @comment = current_user.comments.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '送信失敗！'
      render 'new'
    end
  end

  def destroy
    @comment = comment.find(params[:id])
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
