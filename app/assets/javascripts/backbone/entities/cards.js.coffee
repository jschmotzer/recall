@Recall.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Card extends Entities.Model
    urlRoot: -> Routes.deck_card_path()

  class Entities.CardsCollection extends Entities.Collection

    initialize: (options) ->
      {deck_id} = options
      @deck_id = deck_id
       
    model: Entities.Card
    url: -> Routes.deck_cards_path(@deck_id)

  API =
    getCardEntities: (deck_id) ->
      cards = new Entities.CardsCollection
        deck_id: deck_id
      cards.fetch()
      cards

  App.reqres.setHandler "card:entities", (deck_id) ->
    API.getCardEntities deck_id