@Recall.module "CardsApp", (CardsApp, App, Backbone, Marionette, $, _) ->

  class CardsApp.Layout extends App.Views.LayoutView
    className: 'slides'
    template: 'cards/templates/layout'

    regions:
      cardMain: '#card-main'

    events:
      'click a.next': (event) -> App.execute('card:next')
      'click a.prev': (event) -> App.execute('card:prev')

    initialize: (options)->
      @options = options
