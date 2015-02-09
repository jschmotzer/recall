@Recall.module "CardsApp", (CardsApp, App, Backbone, Marionette, $, _) ->

  API =
    show: (id) ->
      new CardsApp.Controller
        deck_id: id
        region: Recall.mainRegion