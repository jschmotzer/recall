Rails.application.routes.draw do
  root to: 'home#index'

  resources :decks do
    resources :cards
  end
end
