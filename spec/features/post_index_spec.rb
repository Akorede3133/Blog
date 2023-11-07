require 'rails_helper'

RSpec.describe 'Post', type: :feature do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.new(author: user, title: 'Hello', text: 'This is my first post') }

  before { user.save }

  context 'index page' do
    it "show user's username" do
      visit user_posts_path(user)
      expect(page).to have_content(user.name)
    end
    it "shows user's profile picture" do
      visit user_posts_path(user)
      expect(page).to have_selector("img[src='#{user.photo}']")
    end
    it 'shows the number of posts for each user' do
      visit user_posts_path(user)
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
    it "shows a post's title" do
      visit user_posts_path(user)
      first_recent_post = user.most_recent_posts[0]
      expect(page).to have_content(first_recent_post.title) if first_recent_post
    end
    it "shows some of the post's body." do
      visit user_posts_path(user)
      first_recent_post = user.most_recent_posts[0]
      if first_recent_post
        if first_recent_post.text.length > 200
          expect(page).to have_content("#{first_recent_post.text[0, 200]}...")
        else
          expect(page).to have_content(first_recent_post.text)
        end
      end
    end
  end
  context 'index page' do
    it "shows some of the post's body." do
      visit user_posts_path(user)
      first_recent_post = user.most_recent_posts[0]
      if first_recent_post
        if first_recent_post.text.length > 200
          expect(page).to have_content("#{first_recent_post.text[0, 200]}...")
        else
          expect(page).to have_content(first_recent_post.text)
        end
      end
    end

    it 'shows how many comments a post has.' do
      visit user_posts_path(user)
      first_recent_post = user.most_recent_posts[0]
      expect(page).to have_content("Comments: #{first_recent_post.comments_counter}") if first_recent_post
    end
    it 'shows how many likes a post has.' do
      visit user_posts_path(user)
      first_recent_post = user.most_recent_posts[0]
      expect(page).to have_content("Likes: #{first_recent_post.likes_counter}") if first_recent_post
    end

    it 'shows a section for pagination ' do
      visit user_posts_path(user)
      expect(page).to have_selector('a', text: 'Pagination')
    end
  end
end
