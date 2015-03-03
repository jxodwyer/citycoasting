class CommentsController < ApplicationController

  def create
    if user_signed_in? 
      @stamp = Stamp.find(params[:stamp_id])
      @comment = @stamp.comments.new(comment_params)
      @comment.user_id = current_user.id
      @comment.save
      if @comment.save
        respond_to do |format|
          format.html { redirect_to @stamp, notice: 'Thanks for the Comment!' }
          format.json { render :show, status: :ok, location: @stamp }
        end
      end
    else
      redirect_to new_user_registration_path, notice: "Please sign up to comment on a stamp."
    end
  	
  end

  private

    def comment_params
      params.require(:comment).permit(:comment)
    end
endg