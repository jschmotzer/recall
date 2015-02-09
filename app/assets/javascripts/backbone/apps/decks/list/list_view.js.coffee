@Recall.module "DecksApp.List", (List, App, Backbone, Marionette, $, _) ->

  class DeckItem extends App.Views.ItemView
    tagName: 'li'
    className: 'deck-name'
    template: 'decks/list/templates/deck_item'

    events:
      'click .deck-name': 'deck:Selected'

    deckSelected: ->
      console.log('clicked')
      event.preventDefault()
      name = @model.get('title')
      alert(name)


  class List.View extends App.Views.CompositeView
    childView: DeckItem
    childViewContainer: 'ul'
    template: "decks/list/templates/decks_list"