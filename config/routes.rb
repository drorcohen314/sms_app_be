Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get '/messages/:id' => 'messages#show'
  get '/messages/show_by_sender/:sender' => 'messages#show_by_sender'
  post '/messages', to: 'messages#create'
  post '/messages/update_status/:id', to: 'messages#update_message_status'
  delete '/messages/:id', to: 'messages#destroy'

  get '/users/get_key/:username/:password' => 'users#get_key', as: 'users_get_key'
  post '/users' => 'users#create', as: 'users_create'

  mount ActionCable.server => '/cable'
end
