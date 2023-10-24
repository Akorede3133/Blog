require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.new(name: 'Jerry', photo: 'jerry.png', bio: 'This is Jerry bio', posts_counter: 0) }
  let(:post) do
    Post.new(author: user, title: 'My first post', text: 'Content of my post', comments_counter: 0, likes_counter: 0)
  end

  subject do
    Like.new(user:, post:)
  end

  it 'is valid with the required attributes' do
    expect(subject).to be_valid
  end
end
