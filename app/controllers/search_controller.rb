class SearchController < ApplicationController
  def index
    @query = Article.includes(:user, :rich_text_body).ransack(params[:q])
    @articles = @query.result(distinct: true)
  end
end
