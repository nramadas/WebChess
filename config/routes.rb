WebChess::Application.routes.draw do
  resources :games, only: [:index, :show, :create, :update] do
    resource :white, only: [:show]
    resource :black, only: [:show]
  end

  root to: "games#index"
end