class Post < ApplicationRecord
  belongs_to :user
  
  # 1:多のアソシエーション
  has_many :comments
  
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 255 }
end
