WebChess::Application.routes.draw do
  resources :game, only: [:create, :show, :update]
end