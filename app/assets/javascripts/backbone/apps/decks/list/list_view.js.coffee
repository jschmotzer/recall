@Recall.module "DecksApp.List", (List, App, Backbone, Marionette, $, _) ->

  class List.Layout extends App.Views.LayoutView
    template: "decks/list/templates/list_layout"
    
    regions:
      decksRegion:  "#decks-layout"

  class List.Item extends App.Views.ItemView
    tagName: 'li'
    className: 'deck-name'
    template: 'decks/list/templates/deck_item'

    triggers:
      'click': 'deck:name:clicked'

    deckSelected: ->
      console.log('clicked')
      event.preventDefault()
      name = @model.get('title')
      alert(name)


  class List.View extends App.Views.CompositeView
    childView: List.Item
    childViewContainer: 'ul'
    template: "decks/list/templates/decks_list"