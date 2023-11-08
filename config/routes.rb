Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, except: :edit do
      resources :comments, only: [:create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end
end
