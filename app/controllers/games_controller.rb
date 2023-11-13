require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
  end
  def score
    attempt = params[:word]
    letters = params[:letters].split
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    if !letters.permutation(attempt.size).to_a.include?(attempt.upcase.chars)
      @message = "Sorry but #{attempt} can't be built out of #{letters.join(', ')}"
    elsif !word["found"]
      @message = "Sorry but #{attempt} does not seem to be a valid English word..."
    else
      @message = "Congratulations! #{attempt} is a valid English word!"
    end
  end
end
