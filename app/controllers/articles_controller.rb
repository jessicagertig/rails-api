class ArticlesController < ApplicationController
  #all of the commented out lines below are logic extracted into the Paginable module --> there 'collection' is the var for 'articles' or any other controller
  include Paginable 
  def index
    # articles = Article.recent
    # paginated = paginator.call(
    #   articles,
    #   params: pagination_params,
    #   base_url: request.url
    # )
    paginated = paginate(Article.recent)
    # options = { meta: paginated.meta.to_h, links: paginated.links.to_h }
    # render json: serializer.new(paginated.items, options), status: :ok
    render_collection(paginated)
  end

  def serializer
    ArticleSerializer
  end

  # def paginator
  #   JSOM::Pagination::Paginator.new
  # end

  # def pagination_params
  #   params.permit![:page]
  # end
end