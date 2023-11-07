require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let (:user) { User.first }
  context "index page" do
    it "show user's username" do
      visit user_posts_path(user)
      expect(page).to have_content(user.name)
    end
    it "shows user's profile picture" do
      visit user_posts_path(user)
      expect(page).to have_selector("img[src='#{user.photo}']")
    end
    it "shows the number of posts for each user" do
      visit user_posts_path(user)
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
    it "shows a post's title" do
      visit user_posts_path(user)
      first_recent_post = user.most_recent_posts[0]
      if first_recent_post
      expect(page).to have_content(first_recent_post.title)
      end
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

    it "shows how many comments a post has." do
      visit user_posts_path(user)
      first_recent_post = user.most_recent_posts[0]
      if first_recent_post
        expect(page).to have_content("Comments: #{first_recent_post.comments_counter}")
      end
    end
    it "shows how many likes a post has." do
      visit user_posts_path(user)
      first_recent_post = user.most_recent_posts[0]
      if first_recent_post
        expect(page).to have_content("Likes: #{first_recent_post.likes_counter}")
      end
    end

    it "shows a section for pagination " do
      visit user_posts_path(user)
      expect(page).to have_selector('a', text: 'Pagination')
    end
  end

  context "Click" do
    it "redirects me to that post's show page when I click on a post" do
      visit user_posts_path(user)
      if  user.posts.any?
        first_recent_post = user.most_recent_posts[0]
        click_link first_recent_post.title
        expect(page).to have_current_path(user_post_path(user, first_recent_post))
      end
    end
  end

  context "show page" do
    it "shows the post's title" do
      if  user.posts.any?
        first_recent_post = user.most_recent_posts[0]
        visit user_post_path(user, first_recent_post)
        expect(page).to have_content(first_recent_post.title)
      end
    end

    it "shows the post's author" do
      if  user.posts.any?
        first_recent_post = user.most_recent_posts[0]
        visit user_post_path(user, first_recent_post)
        expect(page).to have_content(first_recent_post.author.name)
      end
    end

    it "shows how many likes the post has." do
      if  user.posts.any?
        first_recent_post = user.most_recent_posts[0]
        visit user_post_path(user, first_recent_post)
        expect(page).to have_content("Likes: #{first_recent_post.likes_counter}")

      end
    end
    it "shows how many comments the post has." do
      if  user.posts.any?
        first_recent_post = user.most_recent_posts[0]
        visit user_post_path(user, first_recent_post)
        expect(page).to have_content("Comments: #{first_recent_post.comments_counter}")

      end
    end

    it "shows how the post body." do
      if  user.posts.any?
        first_recent_post = user.most_recent_posts[0]
        visit user_post_path(user, first_recent_post)
        expect(page).to have_content(first_recent_post.text)
      end
    end

    it "shows how the username of each commentor" do
      if  user.posts.any?
        first_recent_post = user.most_recent_posts[0]
        visit user_post_path(user, first_recent_post)
        if first_recent_post.comments.any?
          first_recent_post.comments.each do |comment|
            expect(page).to have_content(comment.user.name)
          end
        end
      end
    end

    it "shows the comment each commentor left." do
      if  user.posts.any?
        first_recent_post = user.most_recent_posts[0]
        visit user_post_path(user, first_recent_post)
        if first_recent_post.comments.any?
          first_recent_post.comments.each do |comment|
            expect(page).to have_content(comment.text)
          end
        end
      end
    end
  end
end