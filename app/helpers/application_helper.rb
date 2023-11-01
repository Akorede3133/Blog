module ApplicationHelper
  def slice_text(text)
    text.length > 50 ? "#{text[0, 200]}..." : text
  end

  def user_already_liked?(post, user)
    user_id = user.id
    like = post.likes.find_by(user: user_id)
    like ? true : false
  end

  def find_like(post, user)
    user_id = user.id
    post.likes.find_by(user: user_id)
  end
end
