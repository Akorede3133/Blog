require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.new(name: 'Jerry', photo: 'jerry.png', bio: 'This is Jerry bio', posts_counter: 0) }
  let(:post) do
    Post.new(author: user, title: 'My first post', text: 'Content of my post', comments_counter: 0, likes_counter: 0)
  end

  subject do
    Like.new(user:, post:)
  end

  before { subject.save }

  it 'is valid with the required attributes' do
    expect(subject).to be_valid
  end

  it 'updates likes counter' do
    subject.update_likes_counter
    expect(post.likes_counter).to eq(1)
  end
end
