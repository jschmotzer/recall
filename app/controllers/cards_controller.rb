class CardsController < ApplicationController
  respond_to :json

  def index
    @cards = find_cards
  end

  def show
  
  end

  private

  def find_cards
    @resource ||= Card.where(deck_id: params[:deck_id]) if params[:deck_id]
  end

end