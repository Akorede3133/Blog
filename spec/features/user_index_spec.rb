require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:user) { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.') }
  let(:post) { Post.new(author: user, title: 'Hello', text: 'This is my first post') }

  before { user.save }
  context 'index page' do
    it 'show username of all other users' do
      visit root_path
      users = User.all
      users.each do |user|
        expect(page).to have_content(user.name)
      end
    end
    it 'shows the profile picture for each user' do
      visit root_path
      users = User.all
      users.each do |user|
        expect(page).to have_selector("img[src='#{user.photo}']")
      end
    end
    it 'shows the number of posts for each user' do
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
end
