class CommentsController < ApplicationController
  inherit_resources
  before_filter :force_user

  def create
    create!{ polymorphic_path(@comment.commentable) }
    current_user.cry("#{current_user} commented on #{@comment.commentable}", :subject => @comment, :action => :commented)
  end

  private

  # Always ensure the user_id is for the current user
  def force_user
    params[:comment][:user_id] = current_user.id
  end
end