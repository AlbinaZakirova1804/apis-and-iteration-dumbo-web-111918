require 'rest-client'
require 'json'
require 'pry'


def get_and_parse_data(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
end

def get_character(character_name)
  character_array = []
  response_hash = get_and_parse_data("https://swapi.co/api/people/")
  is_end = false
  until is_end
    next_page = response_hash['next']
    character_array.concat(response_hash['results'])
    if response_hash['next'] == nil
      is_end = true
    else
      response_hash = get_and_parse_data(next_page)
    end
  end
  character_array.find do |person_info|
    person_info['name'] ==character_name
  end
end

def get_character_movies_from_api(character_name)

  character_hash = get_character(character_name)

  films = character_hash['films']

  films.map do |film|
    film_info = get_and_parse_data(film)
  end
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request  to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  films.each_with_index do |film,i|
    puts "#{i+1} #{film['title']}"
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
