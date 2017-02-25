class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]
  before_action :owned_entry, only: [:edit, :update, :destroy]  

  # list all entries
  def index
    @entries = Entry.of_followed_users(current_user.following).order('created_at DESC')
  end

  # show a specific entry
  def show
  end

  # renders form to create new entry
  def new
    @entry = Entry.new
  end

  # creates a new entry
  def create
    @entry = Entry.new(user_id: current_user.id)
    @entry.update(entry_params)
    if @entry.save
      redirect_to entry_path(@entry)
    else
      redirect_to controller: 'entries', action: 'new'
    end
  end

  # renders form to edit entry
  def edit
  end

  # updates entry
  def update
    if @entry.update(entry_params)
      redirect_to entry_path(@entry)
    else
      redirect_to controller: 'entries', action: 'edit'
    end
  end

  # deletes an entry
  def destroy
    @entry.destroy
    redirect_to entries_path
  end

  private
  # Finds the specific entry
  def set_entry
    @entry = Entry.find_by(id: params[:id])
  end

  # strong params for entry
  def entry_params
    params.require(:entry).permit(:title, :content)
  end

  # checks if a user owns an entry to ensure that a user can't edit
  # other user's entries
  def owned_entry  
    unless current_user == @entry.user
      flash[:alert] = "That entry doesn't belong to you!"
      redirect_to root_path
    end
  end  
end
