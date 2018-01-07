class LikesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    flash[:success] = "質問をLikeしました！"
    redirect_to root_url
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unlike(post)
    flash[:danger] = "質問のLikeを解除しました！"
    redirect_to root_url
  end
end
