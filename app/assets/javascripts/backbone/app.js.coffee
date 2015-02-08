@Recall = do (Backbone, Marionette) ->

  App = new Marionette.Application

  App.rootRoute = Routes.decks_path()

  App.addRegions
    headerRegion: "#header-region"
    leftPaneRegion: "#leftPane-region"
    rightPaneRegion: "#rightPane-region"
    mainRegion: "#main-region"

  App.addInitializer ->

  App.on "start", (options) ->
    if Backbone.history
      Backbone.history.start()
      @navigate(@rootRoute, trigger: true) if @getCurrentRoute() == ""

  App