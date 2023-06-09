require 'rails_helper'

RSpec.describe 'posts', type: :feature do
  describe 'posts/index' do
    before(:each) do
      @user = [
        User.create(
          name: 'Burak',
          photo: 'https://pics.com',
          bio: 'Software Engineer Turkey',
          postscounter: 2
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
      @second_post = Post.create(
        author: @first_user,
        title: 'How are you?',
        text: 'This is my second post from Burak',
        commentscounter: 0,
        likescounter: 1
      )
      @first_comment = Comment.create(post: @first_post, author: @first_user, text: 'First comment for Burak')
      @second_comment = Comment.create(post: @second_post, author: @first_user, text: 'Second comment for Burak')
      @first_like = Like.create(post: @first_post, author: @first_user)
      @second_like = Like.create(post: @second_post, author: @first_user)

      visit user_posts_path(@first_user)
    end

    it 'shows the author image' do
      expect(page).to have_css('img')
    end

    it 'shows the author name' do
      expect(page).to have_content(@first_user.name)
    end

    it 'shows the number of posts by the author' do
      expect(page).to have_content("Number of posts: #{@first_user.postscounter}")
    end

    it 'shows the post title' do
      expect(page).to have_content(@first_post.title)
    end

    it 'shows the post text/body' do
      expect(page).to have_content(@first_post.text)
    end

    it 'shows the first comments on the post' do
      expect(page).to have_content(@first_comment.text)
    end

    it 'shows the number of comments on the post' do
      expect(page).to have_content("Comments: #{@first_post.commentscounter}")
    end

    it 'shows the number of likes on the post' do
      expect(page).to have_content("Likes: #{@first_post.likescounter}")
    end

    it 'shows a section for pagination if there are more posts than fit on the view' do
      expect(page).to have_content('Pagination')
    end

    it "when click on a post, it redirects to the post's show page" do
      visit user_posts_path(@first_user)
      click_link @first_post.title
      expect(current_path).to match(user_posts_path(@first_user.id))
    end
  end
end
