require 'net/http'
require 'json'

class PixnetApi
  attr_accessor :uri, :params
  attr_reader :keyword

  def initialize(keyword, limit = 20)
    @keyword = keyword
  end

  def search
    @uri = URI('https://emma.pixnet.cc/blog/articles/search')
    @params = { format: "json", key: keyword, type: "tag", orderby: "public_at_asc", content_filter: "on" }
    articles = get_api
    articles.present? ? articles.map { |article| Hash["article_id", article["id"], "site_category", article["site_category"], "title", article["title"], "public_at", article["public_at"], "link", article["link"], "image", article["thumb"], "hit", article["info"]["hit"]] } : nil
  end

  private

  def get_api
    uri.query = URI.encode_www_form(params)
    response = Net::HTTP.get(uri)
    articles = response.present? ? JSON.parse(response)["articles"] : nil
  end
end
