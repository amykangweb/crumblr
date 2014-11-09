class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

  respond_to :html

  def index
    @posts = Post.all
    respond_with(@post)
  end

  def show
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
    redirect_to(root_url)
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
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
