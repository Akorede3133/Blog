class User < ApplicationRecord
  has_many :comments
  has_many :likes
  has_many :posts, foreign_key: 'author_id'
  has_many :posts, through: :likes, foreign_key: 'author-id'
end