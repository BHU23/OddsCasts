require 'rails_helper'

describe 'Movies Page', type: :system do
  let(:movie_client_service) { instance_double(MovieClientService) }

  context 'when movies are available' do
    let(:movies) do
      [
        { title: 'Inception', overview: 'A mind-bending thriller.', poster_path: '/inception.jpg' },
        { title: 'The Dark Knight', overview: 'A dark, thrilling superhero film.', poster_path: '/dark-knight.jpg' }
      ]
    end

    before do
      allow(MovieClientService).to receive(:new).and_return(movie_client_service)
      allow(movie_client_service).to receive(:get_movies).and_return(movies)
    end

    it 'displays the movies' do
      visit '/movies' 
      expect(page).to have_selector('h1', text: 'Movies')
      movies.each do |movie|
        expect(page).to have_selector('h2', text: movie[:title])
        expect(page).to have_selector('p', text: movie[:overview])
        expect(page).to have_selector("img[src='#{movie[:poster_path]}']")
      end
    end
  end

  context 'when no movies are available' do
    before do
      allow(MovieClientService).to receive(:new).and_return(movie_client_service)
      allow(movie_client_service).to receive(:get_movies).and_return([])
    end

    it 'displays a no movies found message' do
      visit '/movies' 
      expect(page).to have_text('No movies found.')
    end
  end
end
# require 'spec_helper'
# require 'rails_helper'

# describe 'External request' do
#     it 'queries movies on TMDB' do
#         visit '/movies' 
#         expect(page).to have_text('Movies')
#     end
# end
