class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_article

  def create
   
    @comment = @article.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Comment created"
    else
      flash[:notice] = "Comment has not been created"
    end

    redirect_to article_path(@article)
  end

  def update
    @comment = @article.comments.find(params[:id])

    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to article_url(@article), notice: 'comment updated' }
      else
        format.html { redirect_to article_url(@article), alert: 'comment not updated' }
      end
    end
  end
   

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article), status: :see_other
  end

  private

  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
  end

end
