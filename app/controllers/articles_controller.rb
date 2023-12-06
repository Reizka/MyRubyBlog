class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  

  def index
    @articles = Article.includes([:user, :rich_text_body]).all.order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
    @comments = @article.comments.includes([:user]).order(created_at: :desc)

    mark_notifications_as_read
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def set_article
    @article = Article.find(params[:id])

    # If an old id or a numeric id was used to find the record, then
    # the request slug will not match the current slug, and we should do
    # a 301 redirect to the new path
    redirect_to @article, status: :moved_permanently if params[:id] != @article.slug
  end

  def article_params
    params.require(:article).permit(:title, :body, :status)
  end

  def mark_notifications_as_read
    if current_user
      notifications_to_mark_as_read = @article.notifications.where(recipient: current_user)
      notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
    end
  end
end
