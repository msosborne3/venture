class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_place, only: [:index, :create, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]  

  # list all posts
  def index
    @posts = @place.posts.order("created_at desc")
  end

  # show a specific post
  def show
  end

  # renders form to create new post
  def new
    @post = Post.new
  end

  # creates a new post
  def create
    @post = Post.new(place_id: @place.id)
    @post.update(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      redirect_to controller: 'posts', action: 'new'
    end
  end

  # renders form to edit post
  def edit
  end

  # updates post
  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      redirect_to controller: 'posts', action: 'edit'
    end
  end

  # deletes a post
  def destroy
    @post.destroy
    redirect_to entries_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def set_place
    @place = Place.find(params[:place_id])
  end

  def post_params
    params.require(:post).permit(:link, :description)
  end

  def owned_post  
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end  
end
