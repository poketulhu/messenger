Messengerapi::Application.routes.draw do
  resources :users, :only => [:index] do
    resources :messages, :only => [] do
      get 'search', on: :collection
    end
  end

  resources :sessions, :only => [:create, :destroy]

  resources :conversations, :only => [:create, :index] do
    scope module: :conversations do
      resources :messages, :only => [:create, :index, :update, :destroy]
    end
  end
end