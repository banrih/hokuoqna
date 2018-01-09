class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :user_id, presence: true
  validates :post_id, presence: true
  
  def self.ranking
    self.group(:post_id).order('count_post_id DESC').limit(10).count(:post_id)
  end
end
