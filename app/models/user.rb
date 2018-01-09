class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  # 1:多のアソシエーション
  has_many :posts
  has_many :comments
  
  # Like機能のアソシエーション 
  has_many :likes
  has_many :like_posts, through: :likes, source: :post
  
  def like(post)
    self.likes.find_or_create_by(post_id: post.id)
  end
  
  def unlike(post)
    like = self.likes.find_by(post_id: post.id)
    like.destroy if like
  end
  
  def like_post?(post)
    self.like_posts.include?(post)
  end
end
