class AdminController < ApplicationController
  def index
  end

  def articles
    @article = Article.all.includes(:user)
  end

  def comments
  end

  def users
  end

  def show_article
    @article = Article.includes(:user, :comments).find(params[:id])
  end
end
