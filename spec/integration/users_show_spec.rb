require 'rails_helper'

RSpec.describe 'users/show', type: :feature do
  before(:each) do
    @user = [
      User.create(name: 'Mustafa', photo: 'https://pic.com', bio: 'Software Engineer Turkey',
                  postscounter: 2),
      User.create(name: 'Mert', photo: 'https://pic.com', bio: 'Software Engineer from England',
                  postscounter: 3)
    ]

    @first_user = User.first
    @first_post = Post.create(author: @first_user, title: 'Hello', text: 'This is my first post from Mert',
                              commentscounter: 1, likescounter: 1)
    @second_post = Post.create(author: @first_user, title: 'How are you?', text: 'This is my second post from Mert',
                               commentscounter: 0, likescounter: 1)
    @third_post = Post.create(author: @first_user, title: 'How are you?', text: 'This is my third post from Mert',
                              commentscounter: 0, likescounter: 1)
    visit user_path(@first_user)
  end

  it 'shows the author name' do
    expect(page).to have_content(@first_user.name)
  end

  it 'shows the author image' do
    expect(page).to have_css('img')
  end

  it 'shows the user bio' do
    expect(page).to have_content(@first_user.bio)
  end

  it 'shows number of posts by the author' do
    expect(page).to have_content(@first_user.postscounter)
  end

  it 'shows the users first three posts' do
    expect(page).to have_content(@first_post.text)
    expect(page).to have_content(@second_post.text)
    expect(page).to have_content(@third_post.text)
  end

  it 'shows button to view all posts' do
    expect(page).to have_link('See all Posts')
  end

  it 'redirects to posts show page when users post clicked' do
    visit user_posts_path(@first_user)
    click_link @first_post.title
    expect(current_path).to match(user_posts_path(@first_user.id))
  end

  it 'it redirects me to the users posts index page when i clicked see all posts' do
    click_link 'See all Posts'
    expect(current_path).to match(user_posts_path(@first_user))
  end
end
