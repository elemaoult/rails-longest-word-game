require 'json'
class GamesController < ApplicationController
  def new
    @letters = Array.new(rand(6...12)) { ('A'..'Z').to_a.sample }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def score
    binding.pry
    if params[:word].upcase.chars.all? { |letter| params[:word].upcase.count(letter) <= @letters.count(letter) }
      if english_word?(params[:word])
        "Congratulations! #{params[:word].upcase} is a valid English word..."
      else
        "Sorry but #{params[:word].upcase} does not seem to be valid English word..."
      end
    else
      "Sorry but #{params[:word].upcase} can't be built out of #{@letters}..."
    end
  end
end

# Time to implement the GamesController#score logic. Do we have all the information at hand? What do we need? Do we need to pass more information through the POST request? Have a look at hidden_field_tag.

# We want to handle three scenarios:

# The word can’t be built out of the original grid
# The word is valid according to the grid, but is not a valid English word
# The word is valid according to the grid and is an English word
# (You can use this API to check if a word is valid.)

# At the bottom of the results, add a link_to to go back to the New game page.



