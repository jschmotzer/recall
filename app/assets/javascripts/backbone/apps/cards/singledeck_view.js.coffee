@Recall.module "CardsApp", (CardsApp, App, Backbone, Marionette, $, _) ->

  class CardsApp.SingleDeckView extends App.Views.CompositeView
    className: ''
    template: 'cards/templates/cards'

    childView: CardsApp.CardView

    childViewOptions: (model, index) ->
      if index == 0
        class: 'active'