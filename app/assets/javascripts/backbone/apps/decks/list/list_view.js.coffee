@Recall.module "DecksApp.List", (List, App, Backbone, Marionette, $, _) ->

  class DeckItem extends App.Views.ItemView
    tagName: 'li'
    template: 'decks/list/templates/deck_item'


  class List.View extends App.Views.CompositeView
    childView: DeckItem
    childViewContainer: 'ul'
    template: "decks/list/templates/decks_list"