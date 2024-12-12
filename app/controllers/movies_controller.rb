class MoviesController < ApplicationController
  def index
      client = MovieClientService.new
      @movies = client.get_movies
  end
end
