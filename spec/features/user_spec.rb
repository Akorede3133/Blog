require 'rails_helper'

RSpec.describe 'User', type: :feature do
  context "index page" do
    it "show username of all other users" do
      visit root_path
      users = User.all
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
    it "shows the profile picture for each user" do
      visit root_path
      users = User.all
      users.each do |user|
        expect(page).to have_selector("img[src='#{user.photo}']")
      end
    end
    it "shows the number of posts for each user" do
      visit root_path
      users = User.all
      users.each do |user|
        expect(page).to have_content("Number of posts: #{user.posts_counter}")
      end
    end

    it "redirects me to the user's show page" do
      visit root_path
      users = User.all
      users.each do |user|
        click_link user.name
        expect(page).to have_current_path(user_path(user))
        visit root_path
      end
    end
  end

  context "show page" do
    it 'shows profile picture' do
      user = User.first
      visit user_path(user)
        expect(page).to have_selector("img[src='#{user.photo}']")
    end

    it "show user name" do
      user = User.first
      visit user_path(user)
        expect(page).to have_content(user.name)
    end

    it "show number of posts by the user" do
      user = User.first
      visit user_path(user)
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end

    it "show user bio" do
      user = User.first
      visit user_path(user)
      expect(page).to have_content("#{user.bio}")
    end
    it 'displays the first three posts and a "Show All" button' do
      user = User.first
      posts = user.most_recent_posts
      visit user_path(user)
      puts page.body
      first_post = posts[0]
      second_post = posts[1]
      third_post = posts[2]
      if user.posts.any?
        if first_post
          expect(page).to have_content(first_post.title)
        end
        if second_post
          expect(page).to have_content(second_post.title)
        end
        if third_post
          expect(page).to have_content(third_post.title)
        end
        expect(page).to have_selector('a', text: 'See all posts')
      else
        expect(page).to have_content('This user has no post at the moment')
      end      
    end
  end
end