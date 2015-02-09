@Recall.module "CardsApp", (CardsApp, App, Backbone, Marionette, $, _) ->

  class CardsApp.Controller extends App.Controllers.Base

    commands:
      'card:next': 'nextCard'
      'card:prev': 'prevCard'

    initialize: (options) ->
      {deck_id} = options

      @singleDeck = App.request 'card:entities', deck_id
      # # test = _.findWhere(singleDeck, {id: 4})
      # console.log(singleDeck)
      # test = singleDeck.findWhere({question: "question1"})
      # console.log(test)

      # App.commands.setHandler('card:next', -> )
      #   # 'card:prev': -> 'prevCard'

      layout = new CardsApp.Layout

      @listenTo layout, 'show', =>
        singleDeckView = @singleDeckView(@singleDeck)
        layout.cardMain.show singleDeckView

      @show layout

    singleDeckView: (singleDeck) ->
      new CardsApp.SingleDeckView
        collection: @singleDeck
    
    getLayoutView: ->
      new CardsApp.Layout

    getSlide: ->
      @singleDeck.findWhere({id: 4})

    nextCard: ->
      activeCard = $('.card.active')
      activeCard.removeClass('active')
      activeCard.next().addClass('active')
      
    prevCard: ->
      activeCard = $('.card.active')
      activeCard.removeClass('active')
      activeCard.prev().addClass('active')