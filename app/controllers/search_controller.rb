class SearchController < ApplicationController
  def search
    @users = User.search(params[:search]).order("created_at DESC")
  end
end