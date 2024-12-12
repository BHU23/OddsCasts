require 'rails_helper'

RSpec.describe MovieClientService, type: :service do
  describe '#get_movies' do
    it 'fetches movies from the API' do
      VCR.use_cassette('tmdb_popular_movies') do
        client = MovieClientService.new
        movies = client.get_movies

        expect(movies).to be_an(Array)
        expect(movies.first).to have_key(:title)
        expect(movies.first).to have_key(:overview)
        expect(movies.first).to have_key(:poster_path)
      end
    end
  end
end
