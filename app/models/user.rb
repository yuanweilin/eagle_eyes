class User < ApplicationRecord
  validates :phone, uniqueness: true

  has_many :trips

  def token
    JWT.encode(phone, Rails.application.credentials.secret_key_base)
  end

  def create_trip(articles)
    begin
      trips.create!(articles: articles) if articles.present?
    rescue
      false
    end
  end

  def current_attractions
    trips.last.attractions
  end
end
