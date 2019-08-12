class Api::V1::QuerysController < ApplicationController
  def search
    if params[:keyword]
      articles = PixnetApi.new(params[:keyword]).search
      articles.map{ |article| PixnetArticle.find_or_create_by!(article.merge(keyword: params[:keyword])) }
      pixnet_articles = PixnetArticle.search(params[:keyword])

      render json: pixnet_articles
    else
      head :bad_request
    end
  end
end
