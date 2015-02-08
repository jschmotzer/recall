@Recall.module "DecksApp.List", (List, App, Backbone, Marionette, $, _) ->

  List.Controller = 

    listDecks: ->
      decks = App.request "deck:entities"  

      @view = @getDeckView(decks)

      App.leftPaneRegion.show @view

    getDeckView: (decks) ->
      new List.View
        collection: decks  