collection @decks

attributes :id, :title, :created_at, :updated_at

node do |deck|
  {
    created_at_formatted: deck.created_at.strftime("%m%d%T"),
    update_at_formatted: time_ago_in_words(deck.updated_at)
  }
end