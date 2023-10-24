require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'Jerry', photo: 'jerry.png', bio: 'This is Jerry bio', posts_counter: 0) }
  let(:post) do
    Post.new(author: user, title: 'My first post', text: 'Content of my post', comments_counter: 0, likes_counter: 0)
  end
  subject do
    Comment.new(user:, post:, text: 'This is the comment')
  end

  it 'is valid with the required attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without text' do
    subject.text = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid when text length is less than 1' do
    subject.text = ''
    expect(subject).not_to be_valid
  end

  it 'updates comments_counter' do
    subject.save
    subject.update_comments_counter
    expect(post.comments_counter).to eq(1)
  end
end
