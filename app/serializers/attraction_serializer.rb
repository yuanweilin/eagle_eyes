class AttractionSerializer < ActiveModel::Serializer
  attributes %w(id article_id site_category title public_at link image hit)
end
