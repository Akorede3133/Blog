require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:valid_attributes) { { name: 'Tom', photo: 'tom_photo.jpg', bio: 'This is my short bio', posts_counter: 0 } }  
  describe 'GET /index' do
    it "returns the correct response status" do
      user = User.create! valid_attributes
      get users_url
      expect(response).to have_http_status(200)
    end

    it "response body includes correct placeholder text" do
      get users_url
      expect(response.body).to include("Users")
    end

    it 'renders the correct template' do
      get users_path
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /show' do
    it "returns the correct response status" do
      user = User.create! valid_attributes
      get user_path(user)
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      user = User.create! valid_attributes
      get user_path(user)
      expect(response).to render_template(:show)
    end

    it "response body includes correct placeholder text" do
      user = User.create! valid_attributes
      get user_path(user)
      expect(response.body).to include('This is the detail page for a single user')
    end
  end
end