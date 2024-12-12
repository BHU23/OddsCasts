require 'uri'
require 'net/http'
require 'json'

class MovieClientService
    def get_movies
        url = URI("https://api.themoviedb.org/3/movie/popular?language=en-US&page=1")
        @api_key = Rails.application.credentials.tmdb_api_key

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request["accept"] = 'application/json'
        request["Authorization"] = "Bearer #{@api_key}"

        response = http.request(request)
        body = response.body.force_encoding("UTF-8")
        movies_body = JSON.parse(body)
        movies = []
    
        if movies_body["results"]
            movies_body["results"].each do |m|
            movie = {}
            movie[:title] = m['original_title']
            movie[:overview] = m['overview']
            movie[:poster_path] = "https://image.tmdb.org/t/p/w500/#{m['poster_path']}"
            movies << movie
        end
            puts "No results found or an error occurred."
        end
        # puts movies_body
        movies
    end
end

