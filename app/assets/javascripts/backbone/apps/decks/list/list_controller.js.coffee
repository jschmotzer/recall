@Recall.module "DecksApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Controller extends App.Controllers.Base 

    initialize: ->
      decks = App.request "deck:entities"

      @layout = @getLayoutView decks

      @listenTo @layout, 'show', =>
        @listDecks decks

      @show @layout

    listDecks: (decks)->
      view = @getDeckView(decks)

      @listenTo view, 'childview:deck:name:clicked', (child, args) ->
        App.vent.trigger 'deck:name:clicked', args.model

      @layout.decksRegion.show view

    getDeckView: (decks) ->
      new List.View
        collection: decks

    getLayoutView: (decks) ->
      new List.Layout
        collection: decks