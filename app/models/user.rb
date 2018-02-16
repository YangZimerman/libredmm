class User < ApplicationRecord
  include Clearance::User

  has_many :votes
  has_many :voted_movies, through: :votes, source: :movie

  has_many :upvotes, -> { where(status: :up) }, class_name: 'Vote'
  has_many :upvoted_movies, through: :upvotes, source: :movie

  has_many :downvotes, -> { where(status: :down) }, class_name: 'Vote'
  has_many :downvoted_movies, through: :downvotes, source: :movie

  def unvoted_movies
    Movie.includes(:votes).where(votes: { user: nil }).or(Movie.includes(:votes).where.not(votes: { user: self }))
  end
end
