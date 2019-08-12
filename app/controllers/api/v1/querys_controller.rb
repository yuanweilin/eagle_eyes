class Api::V1::QuerysController < ApplicationController
  def search
    if params[:keyword]
      json = Rails.cache.fetch("pixnet_search_#{params[:keyword]}_#{params[:page]}", expires_in: 1.hours) {
        articles = PixnetApi.new(params[:keyword]).search
        articles.map{ |article| PixnetArticle.find_or_create_by!(article.merge(keyword: params[:keyword])) }
        ActiveModelSerializers::SerializableResource.new(PixnetArticle.search(params[:keyword], params[:page]), {
          each_serializer: PixnetArticleSerializer
        }).as_json
      }

      render json: json
    else
      head :bad_request
    end
  end
end
