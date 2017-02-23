class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]

  # list all of a users entries
  def index
    @entries = current_user.entries
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
  def set_entry
    @entry = Entry.find_by(id: params[:id])
  end

  def entry_params
    params.require(:entry).permit(:title, :content)
  end
end
