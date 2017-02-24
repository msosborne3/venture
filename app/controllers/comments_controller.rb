class CommentsController < ApplicationController
  before_action :set_entry

def create  
  @comment = @entry.comments.build(comment_params)
  @comment.user_id = current_user.id

  if @comment.save
    redirect_to :back
  else
    render root_path
  end
end

private

def comment_params  
  params.require(:comment).permit(:content)
end

def set_entry  
  @entry = Entry.find(params[:entry_id])
end  
end
