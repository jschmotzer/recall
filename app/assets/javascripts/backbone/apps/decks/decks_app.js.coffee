@Recall.module "DecksApp", (DecksApp, App, Backbone, Marionette, $, _) ->

  class DecksApp.Router extends Marionette.AppRouter
    appRoutes:
      "decks": "listDecks"

  API = 
    listDecks: ->
      DecksApp.List.Controller.listDecks()

  App.addInitializer ->
    new DecksApp.Router
      controller: API