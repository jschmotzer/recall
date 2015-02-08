class DecksController < ApplicationController
  respond_to :json

  def index
    puts 'helllllooo###########'
  	@decks = Deck.all
  end
end