class DecksController < ApplicationController
  respond_to :json

  def index
  	@decks = Deck.all
  end

  def show
    @deck = find_deck
  end

  private

  def find_deck
    @resource ||= Deck.where(id: params[:id]).first if params[:id]
  end

end