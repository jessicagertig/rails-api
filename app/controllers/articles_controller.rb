class ArticlesController < ApplicationController
  def index
    articles = Article.all.recent
    render json: serializer.new(articles), status: :ok
  end

  def serializer
    ArticleSerializer
  end
end