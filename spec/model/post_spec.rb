require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.new(name: 'Jerry', photo: 'jerry.png', bio: 'This is Jerry bio', posts_counter: 0) }
  subject { Post.new(author: user, title: 'My first post', text: 'Content of my post', comments_counter: 0, likes_counter: 0) }

  before { subject.save }
  it 'is valid with the required attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid when comments_counter is not an integer' do
    subject.comments_counter = 'a'
    expect(subject).not_to be_valid
  end

  it 'is not valid when comments_counter is less than zero' do
    subject.comments_counter = -10
    expect(subject).not_to be_valid
  end

  it 'is not valid when likes_counter is not an integer' do
    subject.likes_counter = 'a'
    expect(subject).not_to be_valid
  end

  it 'is not valid when likes_counter is less than zero' do
    subject.likes_counter = -1
    expect(subject).not_to be_valid
  end
end