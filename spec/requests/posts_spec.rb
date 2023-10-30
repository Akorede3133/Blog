require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { User.create(name: 'Tom', photo: 'tom_photo.jpg', bio: 'This is my short bio', posts_counter: 0 ) }
  let(:valid_attributes) { { author: user, text: 'Lorem ipsum dior', title: 'Post title', comments_counter: 0, likes_counter: 0 } }
  describe 'GET /index' do
    it "returns the correct response status" do
      get user_posts_path(user)
      expect(response).to have_http_status(200)
    end

    it "response body includes correct placeholder text" do
      get user_posts_path(user)
      expect(response.body).to include("Here is a list of posts for a given user")
    end

    it 'renders the correct template' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it "returns the correct response status" do
      post = Post.create! valid_attributes
      get user_post_path(user, post)
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      post = Post.create! valid_attributes
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it "response body includes correct placeholder text" do
      post = Post.create! valid_attributes
      get user_post_path(user, post)
      expect(response.body).to include('Here is the details of a post for a given user')
    end
  end
end