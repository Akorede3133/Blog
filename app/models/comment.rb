class Comment < ApplicationRecord
  after_commit :update_comments_counter
  belongs_to :user
  belongs_to :post

  validates :text, presence: true, length: { minimum: 1 }

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
