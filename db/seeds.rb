require 'open-uri'
require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
url = 'http://tmdb.lewagon.com/movie/top_rated'

Movie.destroy_all

10.times do |i|
  movies = JSON.parse(URI.open("#{url}?page=#{i + 1}").read)['results']
  movies.each do |movie|
    base_url = 'https://image.tmdb.org/t/p/w500'

    Movie.create(
      title: movie['title'],
      overview: movie['overview'],
      #may to add the poster_backdrop later
      poster_url: "#{base_url}#{movie['poster_path']}",
      rating: movie['vote_average']
    )
  end
end
