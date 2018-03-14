Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "welcome#index"
  
  namespace :api do
    namespace :v1 do
      namespace :users do
        get '/:id/designers', to: 'designers#index'
        post '/:id/designers', to: 'designers#create'
        get '/:id/designers/:designer_id', to: 'designers#show'
      end
      post 'auth', to: 'users#create'
      resources :designers do
        resources :styles do
          resources :style_comments
        end
        resources :designer_comments
      end
    end
  end
end
