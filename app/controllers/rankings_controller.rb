class RankingsController < ApplicationController
  def like
    @ranking_counts = Like.ranking
    @posts = Post.find(@ranking_counts.keys)
  end
end
