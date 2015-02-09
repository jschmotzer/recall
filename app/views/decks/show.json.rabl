object @deck

attributes :id, :title

node :cards do |deck|
  deck.cards
end