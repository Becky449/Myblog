class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.includes(comments: [:author])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.commentscounter = 0
    @post.likescounter = 0
    @post.author = current_user

    if @post.save

      redirect_to "/users/#{current_user.id}/posts", notice: 'Post created successfully!'
    else
      render :new, notice: 'Post could not be created.'
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
