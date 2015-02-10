@Recall.module "DecksApp", (DecksApp, App, Backbone, Marionette, $, _) ->

  class DecksApp.Router extends Marionette.AppRouter
    appRoutes:
      "decks": "listDecks"
      'decks/:id/cards': 'showDeck'

  API = 
    listDecks: ->
      new DecksApp.List.Controller
        region: Recall.leftPaneRegion

    showDeck: (deck_id) ->
      new Recall.CardsApp.Controller
        deck_id: deck_id
        region: Recall.mainRegion
      API.listDecks()

  App.vent.on 'deck:name:clicked', (deck) ->
    deck_id = deck.get('id')
    App.navigate Routes.deck_cards_path(deck_id)
    API.showDeck deck_id

  App.addInitializer ->
    new DecksApp.Router
      controller: API

    API.listDecks()