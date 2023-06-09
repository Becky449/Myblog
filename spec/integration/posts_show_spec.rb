require 'rails_helper'

RSpec.describe 'posts/show', type: :feature do
  before(:each) do
    @user = [
      User.create(
        name: 'Burak',
        photo: 'https://pics.com',
        bio: 'Software Engineer Turkey',
        postscounter: 2
      ),
      User.create(
        name: 'Mert',
        photo: 'https://pics.com',
        bio: 'Software Engineer from Turkey',
        postscounter: 3
      )
    ]

    @first_user = User.first

    @first_post = Post.create(
      author: @first_user,
      title: 'Hello',
      text: 'This is my first post from Burak',
      commentscounter: 1,
      likescounter: 1
    )

    @first_comment = Comment.create(post: @first_post, author: @first_user, text: 'First comment for Burak')
    @second_comment = Comment.create(post: @first_post, author: @first_user, text: 'Second comment for Burak')
    @third_comment = Comment.create(post: @first_post, author: @first_user, text: 'Third comment for Burak')

    @first_like = Like.create(post: @first_post, author: @first_user)
    @second_like = Like.create(post: @first_post, author: @first_user)
    @third_like = Like.create(post: @first_post, author: @first_user)

    visit user_posts_path(@first_user, @first_post)
  end

  it 'shows posts title' do
    expect(page).to have_content(@first_post.title)
  end

  it 'shows posts author' do
    expect(page).to have_content(@first_user.name)
  end

  it 'shows number of comments on the post' do
    expect(page).to have_content(@first_post.commentscounter)
  end

  it 'shows number of likes on the post' do
    expect(page).to have_content(@first_post.likescounter)
  end

  it 'shows the post text/body' do
    expect(page).to have_content(@first_post.text)
  end

  it 'shows username of each commenters on the post' do
    expect(page).to have_content(@first_comment.author.name)
    expect(page).to have_content(@second_comment.author.name)
    expect(page).to have_content(@third_comment.author.name)
  end

  it 'shows the text of each comment on the post' do
    expect(page).to have_content(@first_comment.text)
    expect(page).to have_content(@second_comment.text)
    expect(page).to have_content(@third_comment.text)
  end
end
