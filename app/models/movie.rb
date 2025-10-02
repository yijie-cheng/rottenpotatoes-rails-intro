class Movie < ActiveRecord::Base
  RATINGS = %w[G PG PG-13 R].freeze

  def self.all_ratings
    from_db = distinct.where.not(rating: [nil, ""]).order(:rating).pluck(:rating)
    from_db.presence || RATINGS
  end

  def self.with_ratings(ratings_list)
    return all unless ratings_list.present?
    where('LOWER(rating) IN (?)', Array(ratings_list).map { |r| r.to_s.downcase })
  end
end
