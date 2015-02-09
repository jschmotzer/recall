@Recall.module "DecksApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base 

    initialize: ->
      decks = App.request "deck:entities"

      @listDecks(decks)
      
    listDecks: (decks)->
      @view = @getDeckView(decks)
      App.leftPaneRegion.show @view

    getDeckView: (decks) ->
      new List.View
        collection: decks  