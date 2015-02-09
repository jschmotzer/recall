@Recall.module "DecksApp", (DecksApp, App, Backbone, Marionette, $, _) ->

  class DecksApp.Router extends Marionette.AppRouter
    appRoutes:
      "decks": "listDecks"
      'decks/:id/cards': 'showDeck'

  API = 
    listDecks: ->
      new DecksApp.List.Controller

    showDeck: (deck_id) ->
      new Recall.CardsApp.Controller
        deck_id: deck_id
        region: Recall.mainRegion
      # API.listDecks()

  App.addInitializer ->
    new DecksApp.Router
      controller: API

    # API.listDecks()