class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post
  before_action :check_user, except: [:index]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @comments = @post.comments.all
    respond_with(@comments)
  end

  def show 
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    @comment.save
    redirect_to @post
  end

  def update
    @comment.update(comment_params)
    respond_with(@post)
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_comments_path(@post)
  end

  private

    def check_user
      unless @post.user == current_user || current_user.try(:admin?)
        redirect_to root_url, alert: "You are not authorized."
      end
    end

    def set_post
      @post = Post.find(params[:post_id])
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
