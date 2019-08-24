class User < ApplicationRecord
  validates :phone, uniqueness: true

  has_many :trips

  def token
    JWT.encode(phone, Rails.application.credentials.secret_key_base)
  end
end
