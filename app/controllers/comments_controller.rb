class CommentsController < ApplicationController
  load_and_authorize_resource

  before_filter :find_commentable

  respond_to :js

  def create
    @comment = @task.comments.new params[:comment]
    @comments = @task.comments.order(:created_at)
    if @comment.save
      if params[:close] && params[:task_rating]
        @task.close_with_rating! params[:task_rating].to_i
      end
      @comment = @task.comments.new message: ""
    end
    render 'tasks/reload'
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @task.reload
    @comments = @task.comments.order(:created_at)
    @comment = @task.comments.new message: ""
    render 'tasks/reload'
  end

  private
  def find_commentable
    @task = Task.find params[:task_id]
  end
end
