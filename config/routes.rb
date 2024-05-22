Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users, only: %i[index show] do
    resources :vet_dogs, only: %i[create]
  end
  resources :vet_dogs, only: :destroy do
    member do
      patch :accept
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  post '/walks', to: 'walks#create'
  # Defines the root path route ("/")
  # root "posts#index"
  resources :walks, only: [:index, :create]

  resources :dogs do
    resources :walks, except: %i[update delete]
    resources :prescriptions, except: :destroy
    resources :logs
    resources :markers, only: [:create]
  end

  resources :prescriptions, only: :destroy do
    member do
      patch :complete
    end
  end

  resources :chats, only: %i[index show create] do
    resources :messages, only: [:create]
  end

end
