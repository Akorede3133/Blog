require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'tom_photo.jpg', bio: 'This is my short bio', posts_counter: 0) }

  before { subject.save }

  it 'is valid with the required attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid when posts_counter is not an integer' do
    subject.posts_counter = 'a'
    expect(subject).not_to be_valid
  end

  it 'is not valid when posts_counter is less than zero' do
    subject.posts_counter = -1
    expect(subject).not_to be_valid
  end

  it 'returns three most recents post' do
    10.times do
      Post.create(author: subject, title: 'My first post', text: 'Content of my post', comments_counter: 0,
                  likes_counter: 0)
    end
    returned_posts = subject.most_recent_posts
    expect(returned_posts.length).to eq(3)
  end
end
