class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:upvote, :downvote, :new, :create, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  respond_to :html

  def upvote
    @post = Post.find(params[:id])
    @post.liked_by current_user

    respond_to do |format|
      format.js
    end
  end

  def downvote
    @post = Post.find(params[:id])
    @post.unliked_by current_user
    
    respond_to do |format|
      format.js
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @comments = @post.comments.limit(6)
    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to root_url, notice: "Your post has been created."
  end

  def update
    @post.update(post_params)
    respond_with @post, notice: "Your post has been updated."
  end

  def destroy
    @post.destroy
    flash[:alert] = "Post destroyed."
    redirect_to(root_url)
  end

  private

  def check_user
    unless (@post.user == current_user) || (current_user.admin?)
    redirect_to root_url, alert: "You are not authorized"
  end
  end
  
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
