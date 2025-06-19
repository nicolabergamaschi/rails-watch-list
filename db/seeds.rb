  # This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'open-uri'
require 'json'

top_rated_url = 'https://tmdb.lewagon.com/movie/top_rated'
config_url = 'https://tmdb.lewagon.com/configuration'
# in order to create a functioning url to retrieve the poster images I'll have to assemble it by taking thre
# different information from 2 API urls
# 1. in config_url I can retrieve the base url which is the first part of my path:
# api = {
#       change_keys: [values],
#       images: { base_url: ""http://image.tmdb.org/t/p/"}
#       }
#
# 2. in top_rated_url we can get here the bottom part of the
base_url = URI.open(config_url) do |stream|
  data = JSON.parse(stream.read)
  data['images']['base_url']
end
URI.open(top_rated_url) do |stream|
  second_part_url = JSON.parse(stream.read)
  second_part_url['results'].each do |result|
    Movie.create!({
      title: result['original_title'],
      overview: result['overview'],
      rating: result['vote_average'].to_i,
      poster_url: base_url + 'w500' + result['poster_path']
    })
  end
end

movie_lists = ["Classics", "Thriller", "Comedy", "Fantasy", "Sci-fi", 'Cartoons', "TV-Series"]

movie_lists.each do |list|
  List.create!({
    name: list
  })
end
