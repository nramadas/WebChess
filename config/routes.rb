WebChess::Application.routes.draw do
  resources :games, only: [:create, :show, :update] do
    resource :white, only: [:show]
    resource :black, only: [:show]
  end
end