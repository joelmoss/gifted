Rails.application.routes.draw do
  resources :authors, only: %i[index show] do
    resources :books, only: %i[index show] do
      member do
        get :errata
        get :errata2
        get :error
        post :purchase
      end
    end
    resources :novels, only: %i[index show] do
      member do
        get :error
        post :purchase
      end
    end
  end
  resources :movies, only: :show
end
