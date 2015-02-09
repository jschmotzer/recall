@Recall.module "Controllers", (Controllers, App, Backbone, Marionette, $, _) ->
  
  class Controllers.Base extends Marionette.Controller
    
    close: (args...) ->
      delete @region
      delete @options
      super args
      App.execute "unregister:instance", @, @_instance_id
    
    show: (view) ->
      @listenTo view, "close", @close
      @region.show view

    ## allow us to track the state of the controller by using jQuery.Deferred
    ## EX: you can signal that a controller and it's layout are ready with:
    ##   @isReady.resolve()
    ## and then listen on it with:
    ## $.when(controller.isReady).done(...handler...)
    _initDeferreds: ->
      ## "isReady" should be used for signaling that the controller and its layout are
      ## ready for use
      @isReady = $.Deferred()

    _destroyDeferreds: ->
      @isReady.reject()

    ## allow us to set App.commands and App.reqres handlers that are
    ## added on initialization, and removed on destroy of this instance.
    ## this encapsulates module-specific commands and reqres to their
    ## own controller, and ensures that they are only callable while
    ## their scope (this controller instance) is active.
    commands: {}
    reqres: {}

    _getHandler: (handlerName)->
      if handlerName == '@'
        => @
      else if handlerName[0] == '@' # Return property if handlerName starts with @
        => @[handlerName[1..]]
      else if !_.isFunction(@[handlerName]) # Otherwise it's a function and run it
        throw new Error "Controller does not have method #{handlerName}"
      else
        => @[handlerName].apply(this, arguments)

    _bindHandlers: ->
      for command, handler of @commands
        App.commands.setHandler(command, @_getHandler(handler))

      for reqres, handler of @reqres
        App.reqres.setHandler(reqres, @_getHandler(handler))

    _unbindHandlers: ->
      App.commands.removeHandler(command) for command in Object.keys(@commands)
      App.reqres.removeHandler(reqres) for reqres in Object.keys(@reqres)

    constructor: (options = {}) ->
      @_initDeferreds()
      @region = options.region or App.request "default:region"
      super options
      @_instance_id = _.uniqueId("controller")
      App.execute "register:instance", @, @_instance_id
      @_bindHandlers()

    destroy: ->
      App.execute "unregister:instance", @, @_instance_id
      @_unbindHandlers()
      @_destroyDeferreds()
      @isDestroyed = true
      super

      ## allow us to pass in a controller instance instead of a view
      ## if controller instance, set view to the mainView of the controller
      view = if view.getMainView then view.getMainView() else view
      throw new Error("getMainView() did not return a view instance or #{view?.constructor?.name} is not a view instance") if not view

      @setMainView view
      @_manageView view, options

    getMainView: ->
      @_mainView

    setMainView: (view) ->
      ## the first view we show is always going to become the mainView of our
      ## controller (whether its a layout or another view type).  So if this
      ## *is* a layout, when we show other regions inside of that layout, we
      ## check for the existance of a mainView first, so our controller is only
      ## closed down when the original mainView is closed.

      return if @_mainView
      @_mainView = view
      @listenTo view, "destroy", @destroy, @

    _manageView: (view, options) ->
      if options.loading
        ## show the loading view
        App.execute "show:loading", view, options
      else
        options.region.show view, options

    mergeDefaultsInto: (obj) ->
      obj = if _.isObject(obj) then obj else {}
      _.defaults obj, @_getDefaults()

    _getDefaults: ->
      _.clone _.result(@, "defaults")