@Recall.module "Entities", (Entities, App, Backbone, Marionette, $, _) ->

  class Entities.Deck extends Entities.Model
    urlRoot: -> Routes.decks_path()

  class Entities.DecksCollection extends Entities.Collection
    model: Entities.Deck
    url: -> Routes.decks_path()

  API =
    getDeckEntities: ->
      decks = new Entities.DecksCollection
      decks.fetch()
      decks

  App.reqres.setHandler "deck:entities", ->
    API.getDeckEntities()