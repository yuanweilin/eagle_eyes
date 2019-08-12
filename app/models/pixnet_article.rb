class PixnetArticle < ApplicationRecord
  def self.search(keyword)
    where(keyword: keyword).order(hit: :desc)
  end
end
