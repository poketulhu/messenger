Messengerapi::Application.routes.draw do
  resources :users, :only => [:index]
  resources :sessions, :only => [:create, :destroy]

  resources :conversations, :only => [:create, :index] do
    scope module: :conversations do
      resources :messages, :only => [:create, :index]
    end
  end

  get 'search', to: 'search#search'
end