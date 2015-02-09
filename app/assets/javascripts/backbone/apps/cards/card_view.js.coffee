@Recall.module "CardsApp", (CardsApp, App, Backbone, Marionette, $, _) ->

  class CardsApp.CardView extends App.Views.ItemView
    className: 'card'

    template: 'cards/templates/card'

    initialize: ->
      @$el.addClass(@options.class)