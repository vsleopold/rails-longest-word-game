require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    if word_in_grid? && word_exist?
      @response = "Congratulations, #{params[:game]} is a valid English word."
    elsif word_in_grid? == false
      @response = "Sorry, but #{params[:game]} cannot be built from #{params[:grid]}"
    else
      @response = "Sorry, but #{params[:game]} doesn't seem to be an English word."
    end
    # raise
  end

  def word_in_grid?
    params[:game].chars.all? { |letter| params[:game].count(letter) <= params[:grid].count(letter) }
  end

  def word_exist?
    answer = open("https://wagon-dictionary.herokuapp.com/#{params[:game]}")
    json = JSON.parse(answer.read)
    json['found']
  end
end
