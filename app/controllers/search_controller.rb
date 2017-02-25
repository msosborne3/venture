class SearchController < ApplicationController
  def search
    @users = User.search(params[:search]).order("created_at DESC")
    @places = Place.search(params[:search]).order("created_at DESC")
    @posts = Post.search(params[:search]).order("created_at DESC")
    @entries = Entry.search(params[:search]).order("created_at DESC")
  end
end