Messengerapi::Application.routes.draw do
  resources :users, :only => [:index]

  resources :conversations, :only => [:create, :index] do
    scope module: :conversations do
      resources :messages, :only => [:create, :index]
    end
  end
end