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
end