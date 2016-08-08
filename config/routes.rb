Rails.application.routes.draw do
   root to: 'landing#index'
   get :about, to: 'static_pages#about'
   resources :topics  do
     resources :posts, except: [:show] do
       resources :comments
     end
   end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
