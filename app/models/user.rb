class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true }
  validates :posts_counter, comparison: { greater_than_or_equal_to: 0 }
  validates :username, presence: true, uniqueness: true


  def most_recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
